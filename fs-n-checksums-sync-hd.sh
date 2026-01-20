SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums/checksums")
if [[ -d "${SCRIPT_DIR}/files" ]]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}" && \
mkdir './WORK_IN_PROGRESS' && \
cd './WORK_IN_PROGRESS' && \
mkdir -p './TV' && \
mv '../The Holidays HD' './TV/HD' && \
find './TV' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
mv './TV/HD' '../The Holidays HD' && \
cd '..' && \
rm -r './WORK_IN_PROGRESS' && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/tv-hd-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
cd "${SCRIPT_DIR}" && \
node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"
rm -r "${SCRIPT_DIR}/files"
