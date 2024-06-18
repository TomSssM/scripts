ESCAPE="\033"
RED="${ESCAPE}[0;31m"
GREEN="${ESCAPE}[0;32m"
YELLOW="${ESCAPE}[0;33m"
RESET="${ESCAPE}[0m"

for file in *; do
  'C:\Program Files\eac3to\eac3to.exe' "${file}" -check

  if [ $? -ne 0 ]
  then
    echo -e "${RED}error${RESET}: ${file}"
    exit 1
  else
    echo -e "${GREEN}success${RESET}: ${file}"
  fi
done
