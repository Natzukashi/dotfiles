#!/usr/bin/env bash
LOCKFILE="/tmp/numlock_state"

if [ -f "$LOCKFILE" ]; then
    rm "$LOCKFILE"
    dunstify -a "keyboard" -u low -r 9993 -i "input-keyboard" "Num Lock Off" ""
else
    touch "$LOCKFILE"
    dunstify -a "keyboard" -u low -r 9993 -i "input-keyboard" "Num Lock On" ""
fi
