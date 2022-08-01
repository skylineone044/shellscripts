#!/bin/bash

if [[ $1 != "move" ]] && [[ $1 != "copy" ]]; then
    echo "Unknown operation: $1"; exit 1;
fi

SOURCE=`realpath $2`
DEST=`realpath $3`
MODE=$1
DRY_RUN="--dry-run"

([ -d "$SOURCE" ] || (echo "Directory $SOURCE does not exist"; exit 2;)) &&
([ -d "$DEST" ] || (echo "Directory $DEST does not exist"; exit 2;)) &&
echo "$MODE from $SOURCE to $DEST..."

OPEN_FILES=`find $SOURCE -type f -exec sh -c 'if lsof \`readlink -f {}\` > /dev/null; then echo \`realpath {}\`; fi' \;`
echo "OPEN_FILES: "$OPEN_FILES
EXCLUDE_PATTERNS=""
for file in $OPEN_FILES ; do
    EXCLUDE_PATTERNS+=" --exclude=`realpath --relative-to=\"$SOURCE\" $file`"
done

if [[ $MODE == "copy" ]]; then
    (set -x;
     rsync \
        -avhAXUH \
        $EXCLUDE_PATTERNS \
        "$SOURCE/" \
        $DEST \
        $DRY_RUN
    )
elif [[ $MODE == "move" ]]; then
    (set -x;
     rsync \
        -avhAXUH \
        --remove-source-files \
        $EXCLUDE_PATTERNS \
        "$SOURCE/" \
        $DEST \
        $DRY_RUN
    )
fi
