#!/bin/sh
ssh pi@192.168.1.120 python3 /home/pi/cmd/switch.py R7 || notify-send "fan Error" "Unable to send trigger"

