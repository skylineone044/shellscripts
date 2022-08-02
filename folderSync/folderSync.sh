#!/bin/bash

# Check copy / move mode, if neither then exit with error code 1
if [[ $1 != "move" ]] && [[ $1 != "copy" ]]; then
    echo "Unknown operation: $1"; exit 1;
fi

# use absolute paths
SOURCE=`realpath $2`
DEST=`realpath $3`
MODE=$1
DRY_RUN="--dry-run" # uncomment to enable try run

# check if source and destiantion directories exisit, if not exit with code 2
if [[ ! -d "$SOURCE" ]]; then
    echo "Directory $SOURCE does not exist"; exit 2;
fi

if [[ ! -d "$DEST" ]]; then
    echo "Directory $DEST does not exist"; exit 2;
fi

echo "$MODE from $SOURCE to $DEST..."

# get a list of open files in the source directory
OPEN_FILES=`lsof +D $SOURCE | rg -i " REG " | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=9`
if [[ -z $OPEN_FILES ]]; then
    echo "No open files"
else
    echo "OPEN_FILES: "$OPEN_FILES
fi
# convert the list of absolute paths to "--exclude=/relative/path/from/source/dir" list
EXCLUDE_PATTERNS=""
for file in $OPEN_FILES ; do
    EXCLUDE_PATTERNS+=" --exclude=`realpath --relative-to=\"$SOURCE\" $file`"
done

if [[ $MODE == "copy" ]]; then
    REMOVE_FILES=""
elif [[ $MODE == "move" ]]; then
    REMOVE_FILES="--remove-source-files"
fi

(set -x; # show command before runningf
    rsync \
    -avhAXUH \
    $REMOVE_FILES \
    $EXCLUDE_PATTERNS \
    "$SOURCE/" \
    $DEST \
    $DRY_RUN
)
