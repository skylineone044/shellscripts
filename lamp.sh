#!/bin/sh
ssh pi python3 /home/pi/cmd/switch.py R1 || notify-send "Lamp Error" "Unable to send trigger"

