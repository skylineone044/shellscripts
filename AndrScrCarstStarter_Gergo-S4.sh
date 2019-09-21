#!/bin/sh

adb connect 192.168.1.131:5553
scrcpy --bit-rate 512K --max-size 720
adb disconnect 192.168.1.131:5553
