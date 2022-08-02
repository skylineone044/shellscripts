#!/bin/bash

DEFAULT_CONFIG_FILE_PATH="$XDG_CONFIG_HOME/folderSync.conf"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

if [[ ! -f $1 ]]; then
    if [[ ! -f $DEFAULT_CONFIG_FILE_PATH ]]; then
         echo "No config file provided; exiting"; exit 1;
    else
        CONFIG_FILE=`realpath $DEFAULT_CONFIG_FILE_PATH`
    fi
else
    CONFIG_FILE=`realpath $1`
fi

cat $CONFIG_FILE | while read line || [[ -n $line ]];
do
   echo "config: $line"
   (set -x; bash "$SCRIPT_DIR/folderSync.sh" $line)
   echo ""
done
