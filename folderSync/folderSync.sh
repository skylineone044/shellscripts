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
([ -d "$SOURCE" ] || (echo "Directory $SOURCE does not exist"; exit 2;)) &&
([ -d "$DEST" ] || (echo "Directory $DEST does not exist"; exit 2;)) &&
echo "$MODE from $SOURCE to $DEST..."

# get a list of open files in the source directory
# from: https://serverfault.com/questions/775323/ignore-files-in-use-being-written-to-when-using-rsync
OPEN_FILES=`find $SOURCE -type f -exec sh -c 'if lsof \`readlink -f {}\` > /dev/null; then echo \`realpath {}\`; fi' \;`
echo "OPEN_FILES: "$OPEN_FILES
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
