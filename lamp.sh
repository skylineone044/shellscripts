#!/bin/sh
ssh pi@192.168.1.120 python3 /home/pi/cmd/switch.py 1 || notify-send "Lamp Error" "Unable to send trigger"

