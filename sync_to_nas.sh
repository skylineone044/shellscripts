#!/bin/bash

notify-send "NAS Sync" "Starting: Pictures"
rsync -rvhlpt /mnt/cupcake/Pictures skyline@truenas:/mnt/array/media/

notify-send "NAS Sync" "Starting: Music"
rsync -rvhlpt /mnt/cupcake/Music skyline@truenas:/mnt/array/media/

notify-send "NAS Sync" "Starting: Videos"
rsync -rvhlpt /mnt/cupcake/Videos skyline@truenas:/mnt/array/media/

notify-send "NAS Sync" "Finished"
