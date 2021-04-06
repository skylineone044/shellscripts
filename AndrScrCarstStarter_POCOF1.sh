#!/bin/sh

adb connect 192.168.1.124:5555
scrcpy --bit-rate 25M --max-size 1080
adb disconnect 192.168.1.124:5555
