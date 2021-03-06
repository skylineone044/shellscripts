#!/bin/sh

if [[ $# -eq 1 ]]; then
    let port=$1
else
    let port=5555
fi

adb connect 192.168.1.124:$port
scrcpy --bit-rate 25M --max-size 1920 --encoder 'OMX.qcom.video.encoder.avc'
adb disconnect 192.168.1.124:$port
