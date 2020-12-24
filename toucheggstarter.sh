#!/bin/sh
sleep 5
/usr/bin/touchegg --daemon &
sleep 5
/usr/bin/touchegg --client &
notify-send "touchegg started"
