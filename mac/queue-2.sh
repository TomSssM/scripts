#!/bin/bash

ESCAPE="\033"
GREEN="${ESCAPE}[0;32m"
RESET="${ESCAPE}[0m"
YELLOW="${ESCAPE}[0;33m"

cartoons=(
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Кряк-Бряк'
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Маска'
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Охотники за привидениями'
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Полнометражные'
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Скуби Ду'
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Тимон и Пумба'
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Том и Джерри'
    # './TV/Cartoons/Legacy Stuff/Выходные #1/Мультики/Чёрный плащ'
    # './TV/Cartoons/New/Ghostbusters'
    # './TV/Cartoons/New/Legends of Chima'
    # './TV/Cartoons/New/Over The Garden Wall'
    # './TV/Cartoons/New/Penguins From Madagascar'
    # './TV/Cartoons/New/Quack Pack'
    # './TV/Cartoons/New/Shaggy and Scooby-Doo Get a Clue'
    # './TV/Cartoons/New/SpongeBob/Season 01'
    # './TV/Cartoons/New/SpongeBob/Season 02'
    # './TV/Cartoons/New/SpongeBob/Season 03'
    # './TV/Cartoons/New/The Mask The Animated Series'
    # './TV/Cartoons/New/Woody Woodpecker'
    # './TV/Movies'
)

for cartoon in "${cartoons[@]}"
do
    echo -e ${YELLOW}Started:${RESET} $(du -hs "$cartoon")
    time find "$cartoon" -type f -exec shasum -a 1 {} \; >> ~/db/sha1/tv.txt
    echo -e ${GREEN}Success!${RESET}
    echo
done
