SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums/checksums-2")
if [[ -d "${SCRIPT_DIR}/files" ]]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}/Buffer" && \
find './Main' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Updates' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Torrentino' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Torrentino HD/Cartoonchaos' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Torrentino HD/HD Ready/Projects' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/main.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/updates-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-legacy-stuff-main-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-legacy-stuff-torrent.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-misc.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-new.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-old-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-other-cartoons-cartoons.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-other-cartoons-dvb.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-cc-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-ready-special-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
cd "${SCRIPT_DIR}" && \
node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"
rm -r "${SCRIPT_DIR}/files"
