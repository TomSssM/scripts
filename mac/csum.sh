#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"

outdir="${PWD}/dist"
outfile="${outdir}/log.txt"
base="/Volumes/The Holidays Home HDD/The Holidays/"

if [ ! -d $outdir ]; then
    mkdir $outdir
fi

if [ $# -eq 0 ]
    then
        echo -e "${RED}error:${RESET} please provide the directory to checksum"
        exit 1
fi

cd "$base"

for dirname in "$@"
do
    if [ ! -d "$dirname" ]; then
        echo -e "${RED}error:${RESET} directory ${dirname} doesn't exist"
        cd - > /dev/null
        exit 1
    fi

    dirtocheck="./$(realpath --relative-to="$base" "$dirname")/"

    echo -e ${YELLOW}started:${RESET} $(du -hs "$dirtocheck")
    find "$dirtocheck" -type f -exec shasum -a 1 {} \; >> $outfile

    if [ $? -eq 0 ]
    then
        echo -e "${GREEN}success!${RESET}"
        echo
    else
        echo -e "${RED}error:${RESET} something went wrong while executing shasum"
        echo
        cd - > /dev/null
        exit 1
    fi
done

cd - > /dev/null
