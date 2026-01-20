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

verify_checksums_integrity() {
  local checksums_db=$1

  cd "${DRIVE}/Toolkit/checksums/${checksums_db}"

  local files_count=$(find . -type f -not -path './db/meta/integrity.sha1' | wc -l)
  local checksums_count=$(cat './db/meta/integrity.sha1' | wc -l)

  if [[ $files_count -ne $checksums_count ]]; then
    echo -e "${RED}error:${RESET} files count check failed for ${checksums_db}"
    cd "${SCRIPT_DIR}"
    exit 1
  fi

  shasum -c './db/meta/integrity.sha1' > /dev/null

  if [[ $? -ne 0 ]]; then
    echo -e "${RED}error:${RESET} integrity check failed for ${checksums_db}"
    cd "${SCRIPT_DIR}"
    exit 1
  fi

  cd "${SCRIPT_DIR}"
}

verify_checksums_integrity 'checksums'
verify_checksums_integrity 'checksums-2'
verify_checksums_integrity 'checksums-3'

mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}/Toolkit" && \
find './scripts' -type f >> "${SCRIPT_DIR}/files/files.txt" && \
cd "${DRIVE}/Toolkit/checksums/checksums-3" && \
find './db/sha1' -path './db/sha1/scripts.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums.sha1" && \
cd "${SCRIPT_DIR}" && \
node na-kolenke.js --files "${SCRIPT_DIR}/files/files.txt" --checksum "${SCRIPT_DIR}/files/checksums.sha1"
rm -r "${SCRIPT_DIR}/files"
