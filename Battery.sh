#!/bin/bash

# low battery in %
LOW_BATTERY="40"

# critical battery in % (execute action)
CRITICAL_BATTERY="5"

# action
ACTION="/sbin/poweroff"

# sleep 5 mins
SLEEP="300"

# display icon
LOWBAT_ICON="/usr/share/icons/gnome/32x32/status/battery-low.png"
CRITBAT_ICON="/usr/share/icons/gnome/32x32/status/battery-caution.png"
FULLBAT_ICON="/usr/share/icons/gnome/32x32/status/battery-full-charged.png"

# path to battery /sys
BATTERY_PATH="/sys/class/power_supply/BAT0/"

# notify sound
PLAY="aplay /usr/share/sounds/linuxmint-gdm.wav"

while [ true ]; do
    if [ -e "$BATTERY_PATH" ]; then
        BATTERY_ON=$(cat $BATTERY_PATH/status)
        CURRENT_BATTERY=$(cat $BATTERY_PATH/capacity)

        if [ "$BATTERY_ON" == "Discharging" ]; then

            if [ "$CURRENT_BATTERY" -lt "$CRITICAL_BATTERY" ]; then
                $($PLAY)
                notify-send -i "$CRITBAT_ICON"  "Battery is Critical - $CURRENT_BATTERY%. Shutting down in 60 sec."
                sleep 60
                $($ACTION)

            elif [ "$CURRENT_BATTERY" -lt "$LOW_BATTERY" ]; then
                $($PLAY)
                notify-send -i "$LOWBAT_ICON"  "Battery is Low - $CURRENT_BATTERY%."
            fi

        elif [ "$BATTERY_ON" == "Full" ]; then
            $($PLAY)
            notify-send -i "$FULLBAT_ICON"  "Battery is Full - 100%."
        fi
    fi
    sleep $SLEEP
done
