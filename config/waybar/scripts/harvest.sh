#!/bin/bash

hours=$(/home/$USER/.config/waybar/scripts/harvest -f json | jq '.TodayLoggedHours')

#running_raw=$(/home/$USER/.config/waybar/scripts/harvest entries --from today  -f json | jq ' .[] | select(.running==true) | .id ')
running_raw=$(/home/$USER/.config/waybar/scripts/harvest entries --from today  -f json )
running=""

if [ "$running_raw" !=  "null" ]; then
    running=$( echo $running_raw  | jq ' .[] | select(.running==true) | .id ')
fi

if [ "$running" == "" ]; then
  class="Paused"
else
  class="Running"
fi
tooltip="$(/home/$USER/.config/waybar/scripts/harvest |
    sed 's/\\/\\\\/g' |
    sed ':a;N;$!ba;s/\n/\\n/g' |
    sed 's/"/\\"/g')"

echo '{"text":"'$hours'","tooltip":"<tt>'$tooltip'</tt>","class": "'$class'","alt": "'$class'"}'
