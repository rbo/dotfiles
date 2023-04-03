#!/bin/bash
set -o pipefail

CLI=/usr/bin/darkman

MODE=$(/usr/bin/darkman get)

case $MODE in
    "dark")
        class="dark"
        ;;
    "light")
        class="light"
        ;;
    *)
        class="unknown"
        ;;
esac

echo '{"text":"'$MODE'","tooltip":"<tt>'$MODE'</tt>","class": "'$class'","alt": "'$class'"}'
