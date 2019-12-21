#!/bin/bash

#minecraft afk fishing farm autoclicker

#usage: 1.aim the fiching rod
#       2.tab out
#       3.start this script

# Get all process IDs that match the window class of "Minecraft"
pids=$(xdotool search --class "Minecraft")

# Loop them to find the valid window
for pid in $pids; do
  name=$(xdotool getwindowname $pid)

  if [[ $name == *"Minecraft"* ]]; then
    # Convert decimal PID to hexadecimal
    window_id=$(printf 0x"%x\n" $pid)
    while [ 1 ]; do
    # Start clicking!
      xdotool click --delay 750 --repeat 1 --window $window_id 1
    done
    # Stop looping
    break
  fi

done
