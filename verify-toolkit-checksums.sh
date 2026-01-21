ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"
RED="${ESCAPE}[0;31m"
BOLD="${ESCAPE}[1m"

cd "${DRIVE}/Toolkit/checksums"

for checksums_db in *; do
  cd "${checksums_db}"

  shasum -c ./db/meta/integrity.sha1

  if [[ $? -ne 0 ]]; then
    echo -e "${RED}error${RESET} integrity check failed for ${checksums_db}"
    cd "${SCRIPT_DIR}"
    exit 1
  fi

  cd "${DRIVE}/Toolkit/checksums"
done

cd "${DRIVE}/Toolkit/checksums/checksums-3/db/sha1"

for chunk in *.sha1; do
  cd "${DRIVE}/Toolkit"
  shasum -c "./checksums/checksums-3/db/sha1/${chunk}"

  if [[ $? -ne 0 ]]; then
    echo -e "${RED}error${RESET} integrity check failed for ${chunk}"
    cd "${SCRIPT_DIR}"
    exit 1
  fi
done

echo -e "${GREEN}success${RESET}"
