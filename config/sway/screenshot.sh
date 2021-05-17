#!/usr/bin/env bash
#set -x
#TEMP_DIR=$(mktemp -d)
TEMP_DIR=/tmp/screenshots/
if [ ! -d $TEMP_DIR ] ; then
    mkdir -p $TEMP_DIR
fi

FILENAME=$(date "+%F-%H-%M-%S-%s.png")

SOURCE=$1

if [ "$1" == "wofi" ]; then
    SOURCE=$(echo -e 'focuse_window\nselect\ndesktop' | wofi --show dmenu --width 150 --height 150)
fi;

case $SOURCE in

    focused_window)
        WINDOW=$(swaymsg -t get_tree | \
            jq -r '..
                | (.nodes? // empty)[]
                | select(.focused==true)
                | "\(.rect.x),\(.rect.y-.deco_rect.height) \(.rect.width)x\(.rect.height+.deco_rect.height)"
            ')
        grim -c -g "$WINDOW" ${TEMP_DIR}/${FILENAME}
    ;;
    desktop)
        DESKTOP=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
        grim -o "$DESKTOP" ${TEMP_DIR}/${FILENAME}
    ;;
    focuse_window)
        WINDOW=$(swaymsg -t get_tree | \
            jq -r '..
                | select(.pid? and .visible?)
                | "\(.rect.x),\(.rect.y-.deco_rect.height) \(.rect.width)x\(.rect.height+.deco_rect.height)"
            ' | slurp)
        grim -g "$WINDOW" ${TEMP_DIR}/${FILENAME}
    ;;
    select)
        grim -g "$(slurp)" ${TEMP_DIR}/${FILENAME}
    ;;
    *)
        echo "Please run $0 [focused_window|focuse_window|select|desktop]"
    ;;
esac


if [ -f ${TEMP_DIR}/${FILENAME} ] ; then
    swappy -f ${TEMP_DIR}/${FILENAME}
fi



