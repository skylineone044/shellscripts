#!/bin/bash

skipHEVC=0

counter=0
skipped=0

shopt -s nullglob
for filename in *.mp4; do
    extension="${filename##*.}"
    filename_no_ext="${filename%.*}"
    result_name="${filename_no_ext}_reencoded_hevc.${extension}"
    printf "\nTranscoding $filename to: done/${result_name}...\n"

    if [[ -n $(mediainfo $filename | rg HEVC)  ]] && [[ $skipHEVC -eq 1 ]]; then
        printf "It is HEVC, skipping...\n"
        ((skipped += 1))
    else
        printf "not HEVC\n"
        command="ffmpeg -nostdin \
            -i $filename \
            -c:v hevc_nvenc \
            -rc:v vbr_hq \
            -cq:v 19 \
        done/${result_name}"

        # command="echo bean"

        printf "$command\n"
        $command
        ((counter += 1))
        printf "Transcoded $filename to: done/${result_name}\n"
    fi

done

printf "\nAll done with $counter files! ($skipped skipped)\n"
