#!/usr/bin/env bash
case "$1" in
    up)   wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
    down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
    mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
LEVEL=$(echo "$VOLUME" | awk '{printf "%d", $1 * 100}')

dunstify -a "volume" -u low -r 9991 -h "int:value:$LEVEL" "Volume" ""
