#!/usr/bin/env bash
#set -x
#TEMP_DIR=$(mktemp -d)
TEMP_DIR=$(xdg-user-dir PICTURES)/Screenshots
if [ ! -d $TEMP_DIR ] ; then
    mkdir -p $TEMP_DIR
fi

FILENAME=$(date "+%F-%H-%M-%S-%s.png")

SOURCE=$1

if [ "$1" == "wofi" ]; then
    SOURCE=$(echo -e 'focuse_window\nselect\ndesktop\nMirror Screen\nMirror Selection' | wofi --show dmenu --width 150 --height 150)
fi;

case $SOURCE in

    desktop)
        DESKTOP=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
        grim -o "$DESKTOP" ${TEMP_DIR}/${FILENAME}
    ;;
    focuse_window)
                ## With decoration & borders
                # | "\(.rect.x),\(.rect.y-.deco_rect.height) \(.rect.width)x\(.rect.height+.deco_rect.height)"
                ## Without decoration & borders
                # | "\(.rect.x+.current_border_width),\(.rect.y+.current_border_width) \(.rect.width-(.current_border_width*2))x\(.rect.height-(.current_border_width*2))"
        WINDOW=$(swaymsg -t get_tree | \
            jq -r '..
                | select(.pid? and .visible?)
                | "\(.rect.x+.current_border_width),\(.rect.y+.current_border_width) \(.rect.width-(.current_border_width*2))x\(.rect.height-(.current_border_width*2))"
            ' | slurp)
        grim -g "$WINDOW" ${TEMP_DIR}/${FILENAME}
    ;;
    select)
        grim -g "$(slurp)" ${TEMP_DIR}/${FILENAME}
    ;;
    'Mirror Screen')
        ~/bin/wl-mirror $(slurp -or -f %o)
    ;;
    'Mirror Selection')
        ~/bin/wl-mirror -r "$(slurp -f '%x,%y %wx%h %o')"
    ;;
    *)
        echo "Please run $0 [focused_window|focuse_window|select|desktop]"
    ;;

esac


if [ -f ${TEMP_DIR}/${FILENAME} ] ; then
    swappy -f ${TEMP_DIR}/${FILENAME}
fi

ln -sf ${TEMP_DIR}/${FILENAME} ${TEMP_DIR}/latest.png

