#!/bin/bash

echo -e ${YELLOW}Started:${RESET} $(du -hs "Code")
find ./Code -type f -exec shasum -a 1 {} \; >> ~/Documents/sandbox/checksum/db/sha1/code.txt
echo -e ${GREEN}Success!${RESET}
echo

echo -e ${YELLOW}Started:${RESET} $(du -hs "Data")
find ./Data -type f -exec shasum -a 1 {} \; >> ~/Documents/sandbox/checksum/db/sha1/data.txt
echo -e ${GREEN}Success!${RESET}
echo

echo -e ${YELLOW}Started:${RESET} $(du -hs "My Library")
find './My Library' -type f -exec shasum -a 1 {} \; >> ~/Documents/sandbox/checksum/db/sha1/my-library.txt
echo -e ${GREEN}Success!${RESET}
echo

echo -e ${YELLOW}Started:${RESET} $(du -hs "Pictures")
find ./Pictures -type f -exec shasum -a 1 {} \; >> ~/Documents/sandbox/checksum/db/sha1/pictures.txt
echo -e ${GREEN}Success!${RESET}
echo

echo -e ${YELLOW}Started:${RESET} $(du -hs "The Storybook")
find './The Storybook' -type f -exec shasum -a 1 {} \; >> ~/Documents/sandbox/checksum/db/sha1/the-storybook.txt
echo -e ${GREEN}Success!${RESET}
echo
