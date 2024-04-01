#/usr/bin/env bash
set -x
env | grep XDG

# Notifications
/usr/bin/mako &

# Gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK



swayidle -w \
  timeout 300  ~/.config/sway/lock \
  before-sleep ~/.config/sway/lock
#  timeout 330 'swaymsg "output * dpms off"' \
#  resume 'swaymsg "output * dpms on"' \
#  timeout 30 'if pgrep swaylock; then swaymsg "output * dpms off"; fi' \
#  resume 'if pgrep swaylock; then swaymsg "output * dpms on"; fi' \

#systemctl --user import-environment

#/usr/libexec/xdg-desktop-portal -r &
#/usr/libexec/xdg-desktop-portal-wlr -r &
