#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"

outdir="${PWD}/dist"
outfile="${outdir}/log.sha1.txt"
base="/media/tomsssm/The Holidays Home HDD/The Holidays"

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

# my notes
# exclude directory
# find . -type f -not -path "./.git/*" -exec <command> {} \;
# run shasum not from find command but a file
# cat ~/Projects/checksums/dist/file.txt | xargs -d '\n' shasum -a 1
# find empty directories
# find . -empty -type d
# git create and push tags
# git tag <tagname> [<commit>] && git push --tags
# pipe to tee and make it exit correctly: set -o pipefail ; shasum -a 1 -c "${filepath}" 2>&1 | tee "${logfile}" ; echo $? ; set +o pipefail
