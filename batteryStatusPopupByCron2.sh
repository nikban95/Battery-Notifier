#!/bin/bash
#set the crontab file to run this script after every 2 minutes
#open cron file by sudo crontab -e
#acpi to check the battery status
#-b option for only battery status
#grep for text processing output by acpi
#-o option to only print the content that is matched, not the whole line
#-P option so that we can use perl regular expression i.e ?= or ?<=
#?= means to have any character i.e ? which is equal to % but is not displayed as matched content 
#-u nike is specified with sudo to indicate the username on account of which zenity program will be run

# this environmental variable is needed for running some display and audio commands with crontab.
# Crontab creates new session which doesnot have minimal set of environmental variables.
export DISPLAY=:0

	battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	battery_state=`acpi -b | grep -P -o '[A-Z]+[a-z]+(?=,)'`
	if [ $battery_level -le 20 ] && [ "$battery_state" = "Discharging" ]
		then
		sudo -u nike zenity --warning --title "BATTERY LOW" --text "Battery low $battery_level%."
	fi
	if [ $battery_level -eq 100 ] && [ "$battery_state" = "Charging" ]
		then
		sudo -u nike zenity --warning --title "BATTERY FULL" --text "Battery full $battery_level%."
	fi
