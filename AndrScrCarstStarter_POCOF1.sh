#!/bin/sh

adb connect 192.168.1.124:5555
scrcpy --bit-rate 1M --max-size 720
adb disconnect 192.168.1.124:5555
