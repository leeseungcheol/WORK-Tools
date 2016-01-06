#!/bin/bash
state=0

while :
do
	if [ -e /dev/ttyUSB0 ]
	then
		if [ $state -eq 0 ]
		then
			echo "Uploading..."
			sleep 0.5
			arduino --upload ~/work/ODROID-SHOW/show_main/show_main.ino
			state=1
		else
			echo "Disconnect your SHOW."
		fi
	else
		if [ $state -eq 1 ]
		then
			state=0
		else
			echo "Connect your SHOW."
		fi
	fi
	sleep 1
done
