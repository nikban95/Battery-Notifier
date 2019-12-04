### Battery Notifier

#### What is it about?
- In Linux Mint, the notification for low battery is very subtle. Which generally leads to system shutdown as it gets ignored.
- This is a script which gives popup on low battery(every 5 min) until charger is connected.
- It also speaks the low battery message in English(For scenarios where we are not looking at the system).

#### Dependency:
- espeak
- zenity

#### Setup(Using CronJob):
- Clone the repo at any suitable location.
- Or download the batteryStatusPopupByCron.sh file and save it in any folder.
- Open the crontab file by command: 
````
sudo crontab -e
````
- Append below written code to it. 
````
*/5 * * * * sh ($PATH_TO_FILE)
````
eg:
````
*/5 * * * * sh /home/nike/projects/BatteryNotificationScript/batteryStatusPopupByCron.sh
````
- You can change the interval by changing the number in the above command. Currently is is 5 minutes. You ca change it let's say 10 minutes as well.
- Now the setup is done and you will start receiving notifications on low battery.

Feel free to suggest any changes or contributing to it!!!
