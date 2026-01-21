SCRIPT_DIR=$(pwd)
ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"
BOLD="${ESCAPE}[1m"

if [[ -d "${SCRIPT_DIR}/files" ]]; then
  rm -r "${SCRIPT_DIR}/files"
fi

mkdir "${SCRIPT_DIR}/files"

if [[ $? -ne 0 ]]; then
  echo -e "${RED}error${RESET} couldn't create ${SCRIPT_DIR}/files"
  exit 1
fi

sync_checksums_db() {
  local checksums_db=$1

  cd "${DRIVE}/Toolkit/checksums/${checksums_db}"

  find . -type f -not -path './db/meta/integrity.sha1' > "${SCRIPT_DIR}/files/files.txt"
  cat './db/meta/integrity.sha1' > "${SCRIPT_DIR}/files/checksums.sha1"

  cd "${SCRIPT_DIR}"

  node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"

  if [[ $? -ne 0 ]]; then
    exit 1
  fi
}

echo -n "Checksums:        " && sync_checksums_db 'checksums'
echo -n "Checksums 2:      " && sync_checksums_db 'checksums-2'
echo -n "Checksums 3:      " && sync_checksums_db 'checksums-3'

echo -n '' > "${SCRIPT_DIR}/files/files.txt"
echo -n '' > "${SCRIPT_DIR}/files/checksums.sha1"

cd "${DRIVE}/Toolkit" && \
find './scripts' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
cd "${DRIVE}/Toolkit/checksums/checksums-3" && \
find './db/sha1' -path './db/sha1/scripts.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
cd "${SCRIPT_DIR}" && \
node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"
rm -r "${SCRIPT_DIR}/files"
