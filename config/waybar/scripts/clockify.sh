#!/bin/bash
set -o pipefail
CLI=/home/$USER/.config/waybar/scripts/clockify-cli
export TOKEN=$( $CLI config -f json | jq -r '.token' )
export USER_ID=$( $CLI config -f json | jq -r '.user.id' )
export WORKSPACE=$( $CLI config -f json | jq -r '.workspace' )


today_hours=$($CLI report today --duration-formatted)
week_hours=$($CLI report this-week --duration-formatted)

running=$(curl -s \
    -H "content-type: application/json" \
    -H "X-Api-Key: $TOKEN" \
    -X GET \
    https://api.clockify.me/api/v1/workspaces/${WORKSPACE}/user/${USER_ID}/time-entries?in-progress=true \
| jq length )

if [ "$running" == "0" ]; then
  class="paused"
else
  class="running"
fi

#tooltip="$(/home/$USER/.config/waybar/scripts/harvest |
#    sed 's/\\/\\\\/g' |
#    sed ':a;N;$!ba;s/\n/\\n/g' |
#    sed 's/"/\\"/g')"
tooltip="Today: $today_hours / Week: $week_hours"
echo '{"text":"'$today_hours'","tooltip":"<tt>'$tooltip'</tt>","class": "'$class'","alt": "'$class'"}'
