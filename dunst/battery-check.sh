#!/bin/bash

# Battery percentage threshold
BATTERY_LOW=20
BATTERY_CRITICAL=10

# Get battery info
BATTERY_PATH="/sys/class/power_supply/BAT1"  # Adjust if your battery is named differently
BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
BATTERY_STATUS=$(cat "$BATTERY_PATH/status")

# Only notify if discharging
if [ "$BATTERY_STATUS" = "Discharging" ]; then
    if [ "$BATTERY_LEVEL" -le "$BATTERY_CRITICAL" ]; then
        dunstify -u critical "Battery Critical" "Battery level: ${BATTERY_LEVEL}%"
    elif [ "$BATTERY_LEVEL" -le "$BATTERY_LOW" ]; then
        dunstify -u normal "Battery Low" "Battery level: ${BATTERY_LEVEL}%"
    fi
fi
