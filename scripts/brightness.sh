#!/usr/bin/env bash
# brightness.sh
case "$1" in
up) brightnessctl set 5%+ ;;
down) brightnessctl set 5%- ;;
esac

LEVEL=$(brightnessctl get)
MAX=$(brightnessctl max)
PERCENT=$((LEVEL * 100 / MAX))

dunstify -a "brightness" -u low -r 9992 -h "int:value:$PERCENT" "Brightness: ${PERCENT}%" ""
