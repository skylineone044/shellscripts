#!/bin/bash


pw-loopback -m '[ FL FR]' --playback-props='media.class=Audio/Source node.name=virtual-source-1' &
LOOPBACK_PROCESS_1=$!
echo $LOOPBACK_PROCESS_1
pw-loopback -m '[ FL FR]' --playback-props='media.class=Audio/Source node.name=virtual-source-2' &
LOOPBACK_PROCESS_2=$!
echo $LOOPBACK_PROCESS_2
pw-loopback -m '[ FL FR]' --playback-props='media.class=Audio/Source node.name=virtual-source-3' &
LOOPBACK_PROCESS_3=$!
echo $LOOPBACK_PROCESS_3

sleep infinity

pkill $LOOPBACK_PROCESS_1
pkill $LOOPBACK_PROCESS_2
pkill $LOOPBACK_PROCESS_3

