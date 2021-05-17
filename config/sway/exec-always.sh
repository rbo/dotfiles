#/usr/bin/env bash
set -x
env | grep XDG

# Notifications
/usr/bin/mako &

# Gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK



swayidle -w \
  timeout 300  ~/.config/sway/lock

#/usr/libexec/xdg-desktop-portal -r &
#/usr/libexec/xdg-desktop-portal-wlr -r &
