#!/bin/bash

set -o xtrace
find ./ -name "*_7680x4320.png" -type f -print0 | xargs -0 --max-args=1 --max-procs=16 bash -c 'convert "$1" -resize 8294400@ ${1/7680x4320/3840x2160} && trash "$1"' bash
