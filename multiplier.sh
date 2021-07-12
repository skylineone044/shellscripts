#!/bin/bash
# 21704 x bee movie script makes 1GB
echo "processing..."

for (( i = 0; i < $3+1; i++ )); do   # the third arg ($3) is the multiplier
    cat $1 >> $2   # copy the content in the file given in the first argument to the end of the second argument
    echo "\n" >> $2  # put a linebreak between copies
    echo -e "\r\033[1A\033[0K$i / $3" # status message, overwrite previous one, so it does not print a big column of numbers, but just one
done

