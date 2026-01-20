SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums/checksums")
if [[ -d "${SCRIPT_DIR}/files" ]]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
mkdir "${SCRIPT_DIR}/files/files" && \
mkdir "${SCRIPT_DIR}/files/checksums" && \
cd "${DRIVE}/The Holidays" && \
find './Code' -type f >> "${SCRIPT_DIR}/files/files/code.txt" && \
find './Data' -type f >> "${SCRIPT_DIR}/files/files/data.txt" && \
find './Docs' -type f >> "${SCRIPT_DIR}/files/files/docs.txt" && \
find './My Library' -type f >> "${SCRIPT_DIR}/files/files/my-library.txt" && \
find './Pictures' -type f >> "${SCRIPT_DIR}/files/files/pictures.txt" && \
find './The Storybook' -type f >> "${SCRIPT_DIR}/files/files/the-storybook.txt" && \
find './TV' -type f >> "${SCRIPT_DIR}/files/files/tv.txt" && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/code.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/code.sha1" && \
find './db/sha1' -path './db/sha1/data.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/data.sha1" && \
find './db/sha1' -path './db/sha1/docs.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/docs.sha1" && \
find './db/sha1' -path './db/sha1/my-library.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/my-library.sha1" && \
find './db/sha1' -path './db/sha1/pictures.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/pictures.sha1" && \
find './db/sha1' -path './db/sha1/the-storybook.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/the-storybook.sha1" && \
find './db/sha1' -path './db/sha1/tv-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/tv.sha1" && \
cd "${SCRIPT_DIR}" && \
echo && \
echo -n 'Code:                               ' && cat "${SCRIPT_DIR}/files/files/code.txt" | wc -l && \
echo -n 'Data:                               ' && cat "${SCRIPT_DIR}/files/files/data.txt" | wc -l && \
echo -n 'Docs:                               ' && cat "${SCRIPT_DIR}/files/files/docs.txt" | wc -l && \
echo -n 'My Library:                         ' && cat "${SCRIPT_DIR}/files/files/my-library.txt" | wc -l && \
echo -n 'Pictures:                           ' && cat "${SCRIPT_DIR}/files/files/pictures.txt" | wc -l && \
echo -n 'The Storybook:                      ' && cat "${SCRIPT_DIR}/files/files/the-storybook.txt" | wc -l && \
echo -n 'TV:                                 ' && cat "${SCRIPT_DIR}/files/files/tv.txt" | wc -l && \
echo && \
echo -n 'Code:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/code.txt" --checksum "${SCRIPT_DIR}/files/checksums/code.sha1" && \
echo -n 'Data:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/data.txt" --checksum "${SCRIPT_DIR}/files/checksums/data.sha1" && \
echo -n 'Docs:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/docs.txt" --checksum "${SCRIPT_DIR}/files/checksums/docs.sha1" && \
echo -n 'My Library:                         ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/my-library.txt" --checksum "${SCRIPT_DIR}/files/checksums/my-library.sha1" && \
echo -n 'Pictures:                           ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/pictures.txt" --checksum "${SCRIPT_DIR}/files/checksums/pictures.sha1" && \
echo -n 'The Storybook:                      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/the-storybook.txt" --checksum "${SCRIPT_DIR}/files/checksums/the-storybook.sha1" && \
echo -n 'TV:                                 ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/tv.txt" --checksum "${SCRIPT_DIR}/files/checksums/tv.sha1"
rm -r "${SCRIPT_DIR}/files"
