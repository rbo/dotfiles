#/usr/bin/env bash
set -x
CONNECTED_DISPLAYS=$( xrandr --query | awk '/ connected / { print $1 }' | sort | tr "\n" '#' )

case $CONNECTED_DISPLAYS in

  "eDP1#")
    notify-send "Laptop only setup"
    xrandr | awk '/disconnected/ {print $1}' | while read line ; do xrandr --output $line --off ; done; 
    xrandr --output eDP1 --scale 0.5x0.5
    #xrdb -merge ~/.config/i3/Xresources-hidpi
    ;;

 "DP1-1-1#DP1-1-8#eDP1#")
    notify-send "HomeOffice setup"
    xrdb -remove
    xrandr --output eDP1 --auto --scale 1x1
    xrandr --output DP1-1-8 --auto --primary --right-of eDP1
    xrandr --output DP1-1-1 --auto --right-of DP1-1-8
    #xrandr --output eDP1 --off
    ;;

  "DP1-1#DP1-2#eDP1#")
    notify-send "Red Hat office setup"
    xrdb -remove
    xrandr --output eDP1 --auto --scale 1x1
    xrandr --output DP1-1 --auto --right-of eDP1 --primary
    xrandr --output DP1-2 --auto --right-of DP1-1
    #xrandr --output eDP1 --off
    ;;

  *)
    xrandr --output eDP1 --auto --primary
    #xrdb -merge ~/.config/i3/Xresources-hidpi
    ;;
esac

/usr/bin/feh --bg-scale  ~/.config/i3/background-redhat-3840x2160.png

# Notifications
/usr/bin/dunst &

# Gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK


/usr/bin/setxkbmap \
    -option \
    -option compose:menu \
    -option caps:escape \
    -option compose:prsc
