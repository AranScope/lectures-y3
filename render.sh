#!/bin/bash

OUTPATH="pdf/"

inotifywait -r -m ./ -e moved_to -e modify |
    while read path action file; do
        FNAME="${file%.*}"
        EXT=${file##*.}

        if [[ $EXT = "md" ]]
        then
            INFNAME=${path}${file}
            OUTFNAME=${path}${OUTPATH}${FNAME}
            pandoc --template ./template.tex "${INFNAME}" -o "${OUTFNAME}.pdf" &
            echo "Rendered ${OUTFNAME}"
        fi
    done
