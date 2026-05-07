#!/usr/bin/env bash
case "$1" in
on)
    hyprctl keyword input:touchpad:enabled true
    dunstify -a "touchpad" -u low -r 9994 -i "input-touchpad" "Touchpad On" ""
    ;;
off)
    hyprctl keyword input:touchpad:enabled false
    dunstify -a "touchpad" -u low -r 9994 -i "input-touchpad-off" "Touchpad Off" ""
    ;;
esac
