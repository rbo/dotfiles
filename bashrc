[ -z "$PS1" ] && return
echo "Source .bashrc";
export TERM=screen-256color
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

function settitle() { echo -ne "\033]0;$@\007"; }
function pwd_title() { settitle `basename $(pwd)`; }

# echo 'setting up PATH,MANPATH,EDITOR,LANG env'
export PATH=~/bin:/usr/local/sbin:/usr/local/bin:$PATH
export EDITOR=vim

# echo 'setting up GOPATH
export GOPATH="/Volumes/Development/Go"
export PATH="/Volumes/Development/Go/bin:$PATH"

# echo setting up perl functions pmver/plocate
export PERL_AUTOINSTALL_PREFER_CPAN=1
pmver() { perl -M"$1" -wle "print q{$1: }, \$${1}::VERSION"; }
plocate() { perl -MData::Dumper -e "use $1; print Dumper \%INC"; }

if [ -x "$(command -v powerline-go)" ]; then
    function _update_ps1() {
        rc=$?
        if [ -x "$(command -v powerline-go)" ]; then
            PS1="$(powerline-go -error $rc -max-width 80 -newline -colorize-hostname -modules "ssh,host,user,cwd,perms,git,kube,exit" -priority "ssh,host,cwd,exit,git,kube" -modules-right "time" )"
        else
            PS1="\u@\h:\w $ "
        fi
    }

    if [ "$TERM" != "linux" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
fi


function set-prompt() {
    export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
}


function unset-prompt() {
    unset PROMPT_COMMAND
    export PS1="$ "
}

alias cdate='date +"%F %T %z"'
alias gs='git status'
alias gb='git branch --color '
alias gbl='git bl'
alias gc='git checkout'
alias ga='git add'

# tmux aliases
alias tsh="tmux split-window -h"
alias tsv="tmux split-window -v"

export MINISHIFT_USERNAME='rbohne@redhat.com'

alias kcli='podman run -it --rm --security-opt label=disable -v ~/.kcli:/root/.kcli -v /var/lib/libvirt/images:/var/lib/libvirt/images -v /var/run/libvirt:/var/run/libvirt -v $PWD:/workdir karmab/kcli'

export TERMINAL=gnome-terminal
