#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"

if [ $# -eq 0 ]
    then
        echo -e "${RED}error:${RESET} please provide the name of the db"
        exit 1
fi

filename=$1
filepath="${PWD}/dist/chunks/${filename}.txt"

if [ ! -f $filepath ]; then
    echo -e ${RED}error:${RESET} ${YELLOW}${filepath}${RESET} does not exist
    exit 1
fi

cd '/Volumes/The Holidays Home HDD/The Holidays/'

shasum -a 1 -c $filepath

status=$?

cd - > /dev/null

if [ $status -ne 0 ]
then
    echo -e "${RED}error${RESET} for ${YELLOW}${filename}${RESET}"
    exit 1
else
    echo -e "${GREEN}success${RESET} for ${YELLOW}${filename}${RESET}"
fi
