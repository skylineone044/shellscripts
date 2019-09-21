#!/bin/sh

adb connect 192.168.1.121:5555
scrcpy --bit-rate 128K --max-size 720
adb disconnect 192.168.1.121:5555
