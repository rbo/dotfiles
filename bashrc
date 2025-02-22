# scp? return!
[ -z "$PS1" ] && return
echo "Source .bashrc";

export BASH_COMPLETION_COMPAT_DIR=~/.config/bash_completion.d/

#export TERM=screen-256color
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# echo 'setting up PATH,MANPATH,EDITOR,LANG env'
export PATH=~/bin:~/.local/bin:/usr/local/sbin:/usr/local/bin:$PATH
export EDITOR=vim

function _update_terminal_title() {
    echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"
}

export ARCH=$(uname -m)
if [ -x "$(command -v powerline-go-$ARCH)" ]; then
    function _update_ps1() {
        rc=$?
        if [ -x "$(command -v powerline-go-$ARCH)" ]; then
            if [ -z "$TMUX" ]; then
                export PS1="$(powerline-go-$ARCH -error $rc -max-width 80 -newline -colorize-hostname -modules "ssh,host,user,cwd,perms,git,kube,exit" -priority "ssh,host,cwd,exit,git,kube" -modules-right "time" -condensed -shorten-openshift-names )"
            else
                export PS1="$(powerline-go-$ARCH -error $rc -max-width 80 -colorize-hostname -newline -modules "ssh,host,user,cwd,perms,git,kube,exit" -priority "ssh,host,cwd,exit,git,kube" -condensed -shorten-openshift-names )"
            fi
        else
            export PS1="\u@\h:\w $ "
        fi
    }

    if [ "$TERM" != "linux" ]; then
        export PROMPT_COMMAND="_update_ps1;_update_terminal_title;"
    fi
fi

function set-prompt() {
    export PROMPT_COMMAND="_update_ps1;_update_terminal_title;"
}


function unset-prompt() {
    export PROMPT_COMMAND="_update_terminal_title;"
    export PS1="$ "
}


function get-argocd-admin-pw() {
    oc get secrets -n openshift-gitops  openshift-gitops-cluster -o jsonpath="{.data.admin\.password}" | base64 -d
    echo
}

function get-argocd() {
    URL=$(oc get routes -n openshift-gitops openshift-gitops-server -o go-template="{{ .spec.host }}")
    PW=$(oc get secrets -n openshift-gitops  openshift-gitops-cluster -o go-template='{{index .data "admin.password" | base64decode}}')

    echo "ArgoCD"
    echo "======"
    echo "URL:  https://$URL/"
    echo "User: admin"
    echo "Pass: $PW"
    echo
    echo "argocd login --username admin $URL:443"
    echo
}
alias cdate='date +"%F %T %z"'
alias gs='git status'
alias gb='git branch --color '
alias gbl='git bl'
alias gc='git checkout'
alias ga='git add'

[[ $PS1 && -f /etc/profile.d/bash_completion.sh ]] && \
    . /etc/profile.d/bash_completion.sh

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

[[ -f ~/dotfiles/secret/secret-env.sh ]] && source ~/dotfiles/secret/secret-env.sh
[[ -f ~/bin/switch.sh ]] && source ~/bin/switch.sh

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
