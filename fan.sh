#!/bin/sh
ssh pi python3 /home/pi/cmd/switch.py R7 || notify-send "fan Error" "Unable to send trigger"

