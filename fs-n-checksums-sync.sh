SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums")
if [ -d "${SCRIPT_DIR}/files" ]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}/The Holidays" && \
find './Code' -type f >> "${SCRIPT_DIR}/files/code.txt" && \
find './Data' -type f >> "${SCRIPT_DIR}/files/data.txt" && \
find './Docs' -type f >> "${SCRIPT_DIR}/files/docs.txt" && \
find './My Library' -type f >> "${SCRIPT_DIR}/files/my-library.txt" && \
find './Pictures' -type f >> "${SCRIPT_DIR}/files/pictures.txt" && \
find './The Storybook' -type f >> "${SCRIPT_DIR}/files/the-storybook.txt" && \
find './TV' -type f >> "${SCRIPT_DIR}/files/tv.txt" && \
cd "${SCRIPT_DIR}" && \
echo && \
echo -n 'Code:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/code.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/code.sha1" && \
echo -n 'Data:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/data.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/data.sha1" && \
echo -n 'Docs:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/docs.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/docs.sha1" && \
echo -n 'My Library:                         ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/my-library.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/my-library.sha1" && \
echo -n 'Pictures:                           ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/pictures.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/pictures.sha1" && \
echo -n 'The Storybook:                      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/the-storybook.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/the-storybook.sha1" && \
echo -n 'TV:                                 ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/tv.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/tv.sha1"
rm -r "${SCRIPT_DIR}/files"
