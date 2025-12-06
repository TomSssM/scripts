#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"

outdir="${PWD}/dist"
outfile="${outdir}/log.sha1.txt"
base="/media/tomsssm/The Holidays/"
# base="/media/tomsssm/Локальный диск/"

if [ $# -eq 0 ]
    then
        echo -e "${RED}error:${RESET} please provide a path to a file of what to checksum"
        exit 1
fi

chunkfile=$(realpath $1)

if [ ! -f $chunkfile ]; then
    echo -e "${RED}error:${RESET} file $chunkfile doesn't exist"
    exit 1
fi

if [ ! -d $outdir ]; then
    mkdir $outdir
fi

cd "$base"

cat $chunkfile | xargs -d '\n' shasum -a 1 > $outfile

if [ $? -ne 0 ]
then
    echo -e "${RED}error:${RESET} something went wrong while running shasum"
    exit 1
else
    echo -e "${GREEN}success!${RESET}"
fi
