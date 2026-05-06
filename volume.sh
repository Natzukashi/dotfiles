#!/usr/bin/env bash
# volume.sh
case "$1" in
up) wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac

MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)
LEVEL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}')

if [ "$MUTED" -gt 0 ]; then
    dunstify -a "volume" -u low -r 9991 -h "int:value:$LEVEL" "Volume: Muted" ""
else
    dunstify -a "volume" -u low -r 9991 -h "int:value:$LEVEL" "Volume: ${LEVEL}%" ""
fi
