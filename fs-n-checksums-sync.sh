if [ -d ~/Projects/scripts/files ]; then
  rm -r ~/Projects/scripts/files
fi
mkdir ~/Projects/scripts/files && \
cd '/h/The Holidays' && \
find './Code' -type f >> ~/Projects/scripts/files/code.txt && \
find './Data' -type f >> ~/Projects/scripts/files/data.txt && \
find './Docs' -type f >> ~/Projects/scripts/files/docs.txt && \
find './My Library' -type f >> ~/Projects/scripts/files/my-library.txt && \
find './Pictures' -type f >> ~/Projects/scripts/files/pictures.txt && \
find './The Storybook' -type f >> ~/Projects/scripts/files/the-storybook.txt && \
find './TV' -type f >> ~/Projects/scripts/files/tv.txt && \
cd ~/Projects/scripts && \
echo && \
echo -n 'Code:                               ' && node na-kolenke.js --files ./files/code.txt --checksum ../checksums/db/sha1/code.txt && \
echo -n 'Data:                               ' && node na-kolenke.js --files ./files/data.txt --checksum ../checksums/db/sha1/data.txt && \
echo -n 'Docs:                               ' && node na-kolenke.js --files ./files/docs.txt --checksum ../checksums/db/sha1/docs.txt && \
echo -n 'My Library:                         ' && node na-kolenke.js --files ./files/my-library.txt --checksum ../checksums/db/sha1/my-library.txt && \
echo -n 'Pictures:                           ' && node na-kolenke.js --files ./files/pictures.txt --checksum ../checksums/db/sha1/pictures.txt && \
echo -n 'The Storybook:                      ' && node na-kolenke.js --files ./files/the-storybook.txt --checksum ../checksums/db/sha1/the-storybook.txt && \
echo -n 'TV:                                 ' && node na-kolenke.js --files ./files/tv.txt --checksum ../checksums/db/sha1/tv.txt
rm -r ~/Projects/scripts/files
