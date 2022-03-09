#!/bin/bash
set -o pipefail
CLI=/home/$USER/.config/waybar/scripts/clockify-cli

today_hours=$($CLI report today --duration-formatted)
week_hours=$($CLI report this-week --duration-formatted)

$CLI show current -q > /dev/null && class=running || class=paused

#tooltip="$(/home/$USER/.config/waybar/scripts/harvest |
#    sed 's/\\/\\\\/g' |
#    sed ':a;N;$!ba;s/\n/\\n/g' |
#    sed 's/"/\\"/g')"
tooltip="Today: $today_hours / Week: $week_hours"
echo '{"text":"'$today_hours'","tooltip":"<tt>'$tooltip'</tt>","class": "'$class'","alt": "'$class'"}'
