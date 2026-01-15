SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums-2")
if [ -d "${SCRIPT_DIR}/files" ]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}/Buffer" && \
find './Torrentino HD/Novo StreamFab' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Torrentino HD/Storage HD' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
find './Torrentino HD/widescreen rips' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/torrentino-hd-fab-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-storage-hd-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-cc.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-dht-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-localized.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-rutracker.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-scripts.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-unsorted.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
cd "${SCRIPT_DIR}" && \
node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"
rm -r "${SCRIPT_DIR}/files"
