SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums-2")
if [ -d "${SCRIPT_DIR}/files" ]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
cd "${DRIVE}" && \
find ./Buffer/2-0 -type f >> "${SCRIPT_DIR}/files/buffer-2-0.txt" && \
find ./Buffer/3-0 -not -path './Buffer/3-0/Updates/*' -type f >> "${SCRIPT_DIR}/files/buffer-3-0.txt" && \
find ./Buffer/3-0/Updates -type f >> "${SCRIPT_DIR}/files/buffer-3-0-updates.txt" && \
cd ./Buffer && \
find './Storage HD' -type f >> "${SCRIPT_DIR}/files/storage-hd.txt" && \
find './Torrentino 4' -type f >> "${SCRIPT_DIR}/files/torrentino-4.txt" && \
find './Torrentino 5' -type f >> "${SCRIPT_DIR}/files/torrentino-5.txt" && \
find './Torrentino HD' -maxdepth 1 -mindepth 1 -type f >> "${SCRIPT_DIR}/files/torrentino-hd.txt" && \
find './Torrentino HD/Cartoonchaos' -type f >> "${SCRIPT_DIR}/files/torrentino-hd-cc.txt" && \
find './Torrentino HD/Novo StreamFab' -type f >> "${SCRIPT_DIR}/files/torrentino-hd-fab.txt" && \
find './Torrentino HD/HD Ready' -type f >> "${SCRIPT_DIR}/files/torrentino-hd-ready.txt" && \
find './Torrentino HD/widescreen rips' -type f >> "${SCRIPT_DIR}/files/torrentino-hd-wide.txt" && \
cd "${SCRIPT_DIR}" && \
echo && \
echo -n '2-0:                               ' && cat "${SCRIPT_DIR}/files/buffer-2-0.txt" | wc -l && \
echo -n '3-0:                               ' && cat "${SCRIPT_DIR}/files/buffer-3-0.txt" | wc -l && \
echo -n '3-0 (Updates):                     ' && cat "${SCRIPT_DIR}/files/buffer-3-0-updates.txt" | wc -l && \
echo -n 'Storage HD:                        ' && cat "${SCRIPT_DIR}/files/storage-hd.txt" | wc -l && \
echo -n 'Torrentino 4:                      ' && cat "${SCRIPT_DIR}/files/torrentino-4.txt" | wc -l && \
echo -n 'Torrentino 5:                      ' && cat "${SCRIPT_DIR}/files/torrentino-5.txt" | wc -l && \
echo -n 'Torrentino HD:                     ' && cat "${SCRIPT_DIR}/files/torrentino-hd.txt" | wc -l && \
echo -n 'Torrentino HD (Cartoonchaos):      ' && cat "${SCRIPT_DIR}/files/torrentino-hd-cc.txt" | wc -l && \
echo -n 'Torrentino HD (Novo StreamFab):    ' && cat "${SCRIPT_DIR}/files/torrentino-hd-fab.txt" | wc -l && \
echo -n 'Torrentino HD (HD Ready):          ' && cat "${SCRIPT_DIR}/files/torrentino-hd-ready.txt" | wc -l && \
echo -n 'Torrentino HD (widescreen rips):   ' && cat "${SCRIPT_DIR}/files/torrentino-hd-wide.txt" | wc -l && \
echo && \
echo -n '2-0:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/buffer-2-0.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/buffer-2-0.txt" && \
echo -n '3-0:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/buffer-3-0.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/buffer-3-0.txt" && \
echo -n '3-0 (Updates):                     ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/buffer-3-0-updates.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/buffer-3-0-updates.txt" && \
echo -n 'Storage HD:                        ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/storage-hd.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/storage-hd.txt" && \
echo -n 'Torrentino 4:                      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/torrentino-4.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/torrentino-4.txt" && \
echo -n 'Torrentino 5:                      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/torrentino-5.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/torrentino-5.txt" && \
echo -n 'Torrentino HD:                     ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/torrentino-hd.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/torrentino-hd.txt" && \
echo -n 'Torrentino HD (Cartoonchaos):      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/torrentino-hd-cc.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/torrentino-hd-cc.txt" && \
echo -n 'Torrentino HD (Novo StreamFab):    ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/torrentino-hd-fab.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/torrentino-hd-fab.txt" && \
echo -n 'Torrentino HD (HD Ready):          ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/torrentino-hd-ready.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/torrentino-hd-ready.txt" && \
echo -n 'Torrentino HD (widescreen rips):   ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/torrentino-hd-wide.txt" --checksum "${CHECKSUMS_DIR}/db/sha1/torrentino-hd-wide.txt"
rm -r "${SCRIPT_DIR}/files"
