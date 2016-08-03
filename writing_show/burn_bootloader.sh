#!/bin/bash
state=0

USB_DEV="/dev/ttyUSB9"

while :
do
	if [ -e $USB_DEV ]
	then
		if [ $state -eq 0 ]
		then
			echo "Uploading..."
			sleep 0.5
			avrdude -c avrisp2 -p atmega328p -P $USB_DEV -b 115200 -e -u -U lock:w:0x3f:m -U efuse:w:0x05:m -U hfuse:w:0xDE:m -U lfuse:w:0xFF:m
			avrdude -c avrisp2 -p atmega328p -P $USB_DEV -b 115200 -U flash:w:optiboot_atmega328.hex:i -U lock:w:0x0f:m
			avrdude -c avrisp2 -p atmega328p -P $USB_DEV -b 115200 -D -U flash:w:show_main.hex:i
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
