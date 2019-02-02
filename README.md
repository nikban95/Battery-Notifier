# Battery-Notifier
This is a script which gives popup on low battery in Linux Mint.
It also speaks the low battery message in English.

Dependency:

1. espeak

2. zenity

Usage(Using Crontab):

1. Download the batteryStatusPopupByCron.sh file and save it in any folder.

2. Open the crontab file by command: sudo crontab -e

3. Append below written line to it. 
    
    */2 * * * * sh ($PATH_TO_FILE)
    
    eg: */2 * * * * sh /home/nike/projects/BatteryNotificationScript/batteryStatusPopupByCron.sh
