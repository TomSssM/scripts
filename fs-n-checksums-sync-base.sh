SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums/checksums")
if [[ -d "${SCRIPT_DIR}/files" ]]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}/The Holidays Base" && \
find './Code' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Data' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Docs' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './My Library' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Pictures' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './The Storybook' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './TV' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/code.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/data.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/docs.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/my-library.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/pictures.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/the-storybook.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/tv-new-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/tv-other-cartoons-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
cd "${SCRIPT_DIR}" && \
node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"
rm -r "${SCRIPT_DIR}/files"
