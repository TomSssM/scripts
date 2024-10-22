ESCAPE="\033"
RED="${ESCAPE}[0;31m"
GREEN="${ESCAPE}[0;32m"
YELLOW="${ESCAPE}[0;33m"
RESET="${ESCAPE}[0m"

for file in *; do
  eac3to "${file}" -check

  if [ $? -ne 0 ]
  then
    echo -e "${RED}error${RESET}: ${file}"
    exit 1
  else
    echo -e "${GREEN}success${RESET}: ${file}"
  fi
done

if [ $? -ne 0 ]
then
  echo -e "${RED}Error${RESET}"
  exit 1
else
  echo
  echo -e "${GREEN}All Files Are Success!${RESET}"
fi
