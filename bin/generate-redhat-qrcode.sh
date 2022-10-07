#!/usr/bin/env bash

#set -x

URL="${1:-$(cat - )}"
QRCODE="$HOME/Pictures/qrcode-$(date +%s).png"
echo "URL: $URL"
echo "Save into: $QRCODE"

curl --get -# \
  --globoff \
  -L -o $QRCODE \
  --data-urlencode "data[rounded]=false" \
  --data-urlencode "data[value]=$URL" \
  "https://cdn.make.cm/make/s/rhqrpng" && open $QRCODE


