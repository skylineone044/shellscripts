#!/bin/bash

set -o xtrace

find ./ -name "*.png" -type f -exec bash -c 'convert "$1" -resize 8294400@ ${1/7680x4320/3840x2160} && trash "$1"' bash {} \;
