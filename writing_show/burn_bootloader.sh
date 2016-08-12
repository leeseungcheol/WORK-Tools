#!/bin/bash

#avrdude -c avrisp2 -p m328p -P /dev/ttyUSB0 -U lfuse:r:test3.hex:h
state=0

USB_DEV=$(ls /dev/ttyUSB*)
echo $USB_DEV
echo $USB_DEV
echo $USB_DEV
#USB_DEV="/dev/ttyUSB0"

while :
do
	if [ -e $USB_DEV ]
	then
		if [ $state -eq 0 ]
		then
			echo "Uploading..."
			sleep 0.5
			avrdude -c avrisp2 -p atmega328p -P $USB_DEV -B 4 -e -U efuse:w:0xFF:m -U hfuse:w:0xD8:m -U lfuse:w:0xff:m
			avrdude -c avrisp2 -p atmega328p -P $USB_DEV -U flash:w:optiboot_atmega328.hex:i
			avrdude -c avrisp2 -p atmega328p -P $USB_DEV -D -U flash:w:show_main.hex:i
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
