#!/bin/bash
#set the crontab file to run this script after every 2 minutes
#open cron file by sudo crontab -e
#-u nike is specified with sudo to indicate the username on account of which zenity program will be run

# this environmental variable is needed for running some display and audio commands with crontab.
# Crontab creates new session which doesnot have minimal set of environmental variables.
export DISPLAY=:0

# users lists the currently logged in users
# and awk is used to get the first one of them
notifyUser=`users | awk '{print $1;}'`

# low battery
lowBattery="20"

# path to battery /sys
batteryPath0="/sys/class/power_supply/BAT0/"
batteryPath1="/sys/class/power_supply/BAT1/"

if [ -e "$batteryPath0" ]
	then
	batteryPath=$batteryPath0
elif [ -e "$batteryPath1" ]
	then
	batteryPath=$batteryPath1
else
	batteryPath="NULL"
fi

# -e in if to check if file exists or not
# -e is used instead of -f as to check for any type of file rather than only regular file
if [ -e $batteryPath ]
	then
	batteryLevel=`cat $batteryPath/capacity`
	batteryStatus=`cat $batteryPath/status`

	if [ $batteryLevel -le $lowBattery ] && [ "$batteryStatus" = "Discharging" ]
		then
		sudo -u $notifyUser espeak "Battery Low $batteryLevel percent"
		sudo -u $notifyUser zenity --warning --title "BATTERY LOW" --text "Battery Low $batteryLevel%."
	elif [ "$batteryStatus" = "Full" ]
		then
		sudo -u $notifyUser espeak "Battery Full"
		sudo -u $notifyUser zenity --warning --title "BATTERY FULL" --text "Battery Full $batteryLevel%."
	fi
fi