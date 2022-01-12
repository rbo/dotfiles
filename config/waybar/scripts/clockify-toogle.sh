#!/bin/bash
set -o pipefail

set -x
CLI=/home/$USER/.config/waybar/scripts/clockify-cli
export TOKEN=$( $CLI config -f json | jq -r '.token' )
export USER_ID=$( $CLI config -f json | jq -r '.user.id' )
export WORKSPACE=$( $CLI config -f json | jq -r '.workspace' )

running=$(curl -s \
    -H "content-type: application/json" \
    -H "X-Api-Key: $TOKEN" \
    -X GET \
    https://api.clockify.me/api/v1/workspaces/${WORKSPACE}/user/${USER_ID}/time-entries?in-progress=true \
| jq length )

if [ "$running" == "0" ]; then
  class="paused"

  dsg=$(wofi -d -L 6 -l 3 -W 100 -x -100 -y 10 \
    -D dynamic_lines=true << EOF | sed 's/^ *//'
    E-Mails
    Meeting
    Nothing
EOF
  )

  $CLI in -p 616eab8af02c6203bfa02c34 -d "$dsg"
else
  class="running"
  $CLI out
fi

exit 0
case  in
    "Start")
        $CLI in -p 616eab8af02c6203bfa02c34
        ;;
    "Stop")
        $CLI out
        ;;
esac
