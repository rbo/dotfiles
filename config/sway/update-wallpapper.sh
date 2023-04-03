#!/usr/bin/env bash
set -o pipefail
set -x
echo $1
if [ -z "$1" ] ; then
    MODE=$(/usr/bin/darkman get)
else
    MODE=$1
fi

background="1-Wallpaper-Red_Hat"
resolution="3840x2160"

case $MODE in
    "dark")
        class="Black"
        bgcolor="#000000"
        ;;
    "light")
        class="White"
        bgcolor="#ffffff"
        ;;
    *)
        class="Black"
        bgcolor="#000000"
        ;;
esac

swaymsg output "* background /home/$USER/.config/sway/${background}-${resolution}_Desktop-${class}.png fit $bgcolor"
swaymsg output "'Chimei Innolux Corporation 0x1417 0x00000000'  background /home/$USER/.config/sway/${background}-1920x1200_Desktop-${class}.png fit $bgcolor"

# config:output * background /home/$USER/.config/sway/background-redhat-3840x2160.png fit #000000
# config:output "Chimei Innolux Corporation 0x1417 0x00000000" background /home/$USER/.config/sway/background-redhat-1920x1200.png fit #000000