#!/bin/bash

# make sure $XDG_CONFIG_HOME is defined, if not, set the recommended default value
if [[ ! -d $XDG_CONFIG_HOME ]]; then
    XDG_CONFIG_HOME="$HOME/.config/"
fi

DEFAULT_CONFIG_FILE_PATH="$XDG_CONFIG_HOME/folderSync.conf"
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")" # need to know where the folderSync.sh script is: they should be in the same directory

# 2 ways to set confing file path:
#   1. as the $1 argument
#   2. as the $DEFAULT_CONFIG_FILE_PATH, if no argument is given
# always prefer the argument if provided
if [[ ! -f $1 ]]; then
    if [[ ! -f $DEFAULT_CONFIG_FILE_PATH ]]; then
         echo "No config file provided; exiting"; exit 1;
    else
        CONFIG_FILE=`realpath $DEFAULT_CONFIG_FILE_PATH`
    fi
else
    CONFIG_FILE=`realpath $1`
fi
echo "Using config: $CONFIG_FILE"

# go through the config file, line by line
cat $CONFIG_FILE | while read line || [[ -n $line ]];
do
    if [[ ! -z $line ]]; then # if line is not empty
        echo "config: $line"
        (set -x; bash "$SCRIPT_DIR/folderSync.sh" $line) # run sync job
        echo ""
    fi
done
