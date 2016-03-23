#!/bin/bash
#store at /etc/init.d directory to run at startup and then run update-rc.d command in terminal 
#acpi to check the battery status
#-b option for only battery status
#grep for text processing output by acpi
#-o option to only print the content that is matched, not the whole line
#-P option so that we can use perl regular expression i.e ?= or ?<=
#?= means to have any character i.e ? which is equal to % but is not displayed as matched content 
while [ 1 ]
	do
	battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	if [ $battery_level -le 20 ]
		then
		zenity --warning --title "BATTERY LOW" --text "Battery low $battery_level%"
	fi
	sleep 300
done

