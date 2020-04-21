#!/bin/sh
for i in {1..31}
do
   #echo "Welcome $i times"
   let h=$i*1080-1
   echo "$i:  $h"
   convert -extract 1080x1080+0+$h big.png frame_$i.png
done
