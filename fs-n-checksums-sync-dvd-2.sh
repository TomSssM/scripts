SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums-2")
if [ -d "${SCRIPT_DIR}/files" ]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}/Buffer" && \
find './Torrentino HD/HD Ready/[BluRay]' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Torrentino HD/HD Ready/[DVD]' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/torrentino-hd-ready-dvd-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
cd "${SCRIPT_DIR}" && \
node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"
rm -r "${SCRIPT_DIR}/files"
