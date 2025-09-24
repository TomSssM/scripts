if [ -d ~/Projects/scripts/files ]; then
  rm -r ~/Projects/scripts/files
fi
mkdir ~/Projects/scripts/files && \
cd /h/ && \
find ./Buffer/2-0 -type f >> ~/Projects/scripts/files/buffer-2-0.txt && \
find ./Buffer/3-0 -not -path './Buffer/3-0/Updates/*' -type f >> ~/Projects/scripts/files/buffer-3-0.txt && \
find ./Buffer/3-0/Updates -type f >> ~/Projects/scripts/files/buffer-3-0-updates.txt && \
cd ./Buffer && \
find './Storage HD' -type f >> ~/Projects/scripts/files/storage-hd.txt && \
find './Torrentino 4' -type f >> ~/Projects/scripts/files/torrentino-4.txt && \
find './Torrentino 5' -type f >> ~/Projects/scripts/files/torrentino-5.txt && \
find './Torrentino HD' -maxdepth 1 -mindepth 1 -type f >> ~/Projects/scripts/files/torrentino-hd.txt && \
find './Torrentino HD/Cartoonchaos' -type f >> ~/Projects/scripts/files/torrentino-hd-cc.txt && \
find './Torrentino HD/Novo StreamFab' -type f >> ~/Projects/scripts/files/torrentino-hd-fab.txt && \
find './Torrentino HD/HD Ready' -type f >> ~/Projects/scripts/files/torrentino-hd-ready.txt && \
find './Torrentino HD/widescreen rips' -type f >> ~/Projects/scripts/files/torrentino-hd-wide.txt && \
cd ~/Projects/scripts && \
echo && \
echo -n '2-0:                               ' && cat ./files/buffer-2-0.txt | wc -l && \
echo -n '3-0:                               ' && cat ./files/buffer-3-0.txt | wc -l && \
echo -n '3-0 (Updates):                     ' && cat ./files/buffer-3-0-updates.txt | wc -l && \
echo -n 'Storage HD:                        ' && cat ./files/storage-hd.txt | wc -l && \
echo -n 'Torrentino 4:                      ' && cat ./files/torrentino-4.txt | wc -l && \
echo -n 'Torrentino 5:                      ' && cat ./files/torrentino-5.txt | wc -l && \
echo -n 'Torrentino HD:                     ' && cat ./files/torrentino-hd.txt | wc -l && \
echo -n 'Torrentino HD (Cartoonchaos):      ' && cat ./files/torrentino-hd-cc.txt | wc -l && \
echo -n 'Torrentino HD (Novo StreamFab):    ' && cat ./files/torrentino-hd-fab.txt | wc -l && \
echo -n 'Torrentino HD (HD Ready):          ' && cat ./files/torrentino-hd-ready.txt | wc -l && \
echo -n 'Torrentino HD (widescreen rips):   ' && cat ./files/torrentino-hd-wide.txt | wc -l && \
echo && \
echo -n '2-0:                               ' && node na-kolenke.js --files ./files/buffer-2-0.txt --checksum ../checksums-2/db/sha1/buffer-2-0.txt && \
echo -n '3-0:                               ' && node na-kolenke.js --files ./files/buffer-3-0.txt --checksum ../checksums-2/db/sha1/buffer-3-0.txt && \
echo -n '3-0 (Updates):                     ' && node na-kolenke.js --files ./files/buffer-3-0-updates.txt --checksum ../checksums-2/db/sha1/buffer-3-0-updates.txt && \
echo -n 'Storage HD:                        ' && node na-kolenke.js --files ./files/storage-hd.txt --checksum ../checksums-2/db/sha1/storage-hd.txt && \
echo -n 'Torrentino 4:                      ' && node na-kolenke.js --files ./files/torrentino-4.txt --checksum ../checksums-2/db/sha1/torrentino-4.txt && \
echo -n 'Torrentino 5:                      ' && node na-kolenke.js --files ./files/torrentino-5.txt --checksum ../checksums-2/db/sha1/torrentino-5.txt && \
echo -n 'Torrentino HD:                     ' && node na-kolenke.js --files ./files/torrentino-hd.txt --checksum ../checksums-2/db/sha1/torrentino-hd.txt && \
echo -n 'Torrentino HD (Cartoonchaos):      ' && node na-kolenke.js --files ./files/torrentino-hd-cc.txt --checksum ../checksums-2/db/sha1/torrentino-hd-cc.txt && \
echo -n 'Torrentino HD (Novo StreamFab):    ' && node na-kolenke.js --files ./files/torrentino-hd-fab.txt --checksum ../checksums-2/db/sha1/torrentino-hd-fab.txt && \
echo -n 'Torrentino HD (HD Ready):          ' && node na-kolenke.js --files ./files/torrentino-hd-ready.txt --checksum ../checksums-2/db/sha1/torrentino-hd-ready.txt && \
echo -n 'Torrentino HD (widescreen rips):   ' && node na-kolenke.js --files ./files/torrentino-hd-wide.txt --checksum ../checksums-2/db/sha1/torrentino-hd-wide.txt
rm -r ~/Projects/scripts/files
