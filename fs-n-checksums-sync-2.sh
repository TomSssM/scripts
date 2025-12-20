SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums-2")
if [ -d "${SCRIPT_DIR}/files" ]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
mkdir "${SCRIPT_DIR}/files/files" && \
mkdir "${SCRIPT_DIR}/files/checksums" && \
cd "${DRIVE}/Buffer" && \
find ./2-0 -type f >> "${SCRIPT_DIR}/files/files/buffer-2-0.txt" && \
find ./3-0 -not -path './3-0/Updates/*' -type f >> "${SCRIPT_DIR}/files/files/buffer-3-0.txt" && \
find ./3-0/Updates -type f >> "${SCRIPT_DIR}/files/files/buffer-3-0-updates.txt" && \
find './Storage HD' -type f >> "${SCRIPT_DIR}/files/files/storage-hd.txt" && \
find './Torrentino 4' -type f >> "${SCRIPT_DIR}/files/files/torrentino-4.txt" && \
find './Torrentino 5' -type f >> "${SCRIPT_DIR}/files/files/torrentino-5.txt" && \
find './Torrentino HD' -maxdepth 1 -mindepth 1 -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd.txt" && \
find './Torrentino HD/Cartoonchaos' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-cc.txt" && \
find './Torrentino HD/Novo StreamFab' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-fab.txt" && \
find './Torrentino HD/HD Ready' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-ready.txt" && \
find './Torrentino HD/widescreen rips' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-wide.txt" && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/buffer-2-0-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/buffer-2-0.sha1" && \
find './db/sha1' -path './db/sha1/buffer-3-0.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/buffer-3-0.sha1" && \
find './db/sha1' -path './db/sha1/buffer-3-0-updates-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/buffer-3-0-updates.sha1" && \
find './db/sha1' -path './db/sha1/storage-hd-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/storage-hd.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-4-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-4.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-5.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-5.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-cc-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-cc.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-fab-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-fab.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-ready-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-ready.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
cd "${SCRIPT_DIR}" && \
echo && \
echo -n '2-0:                               ' && cat "${SCRIPT_DIR}/files/files/buffer-2-0.txt" | wc -l && \
echo -n '3-0:                               ' && cat "${SCRIPT_DIR}/files/files/buffer-3-0.txt" | wc -l && \
echo -n '3-0 (Updates):                     ' && cat "${SCRIPT_DIR}/files/files/buffer-3-0-updates.txt" | wc -l && \
echo -n 'Storage HD:                        ' && cat "${SCRIPT_DIR}/files/files/storage-hd.txt" | wc -l && \
echo -n 'Torrentino 4:                      ' && cat "${SCRIPT_DIR}/files/files/torrentino-4.txt" | wc -l && \
echo -n 'Torrentino 5:                      ' && cat "${SCRIPT_DIR}/files/files/torrentino-5.txt" | wc -l && \
echo -n 'Torrentino HD:                     ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd.txt" | wc -l && \
echo -n 'Torrentino HD (Cartoonchaos):      ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-cc.txt" | wc -l && \
echo -n 'Torrentino HD (Novo StreamFab):    ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-fab.txt" | wc -l && \
echo -n 'Torrentino HD (HD Ready):          ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-ready.txt" | wc -l && \
echo -n 'Torrentino HD (widescreen rips):   ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-wide.txt" | wc -l && \
echo && \
echo -n '2-0:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/buffer-2-0.txt" --checksum "${SCRIPT_DIR}/files/checksums/buffer-2-0.sha1" && \
echo -n '3-0:                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/buffer-3-0.txt" --checksum "${SCRIPT_DIR}/files/checksums/buffer-3-0.sha1" && \
echo -n '3-0 (Updates):                     ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/buffer-3-0-updates.txt" --checksum "${SCRIPT_DIR}/files/checksums/buffer-3-0-updates.sha1" && \
echo -n 'Storage HD:                        ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/storage-hd.txt" --checksum "${SCRIPT_DIR}/files/checksums/storage-hd.sha1" && \
echo -n 'Torrentino 4:                      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-4.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-4.sha1" && \
echo -n 'Torrentino 5:                      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-5.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-5.sha1" && \
echo -n 'Torrentino HD:                     ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd.sha1" && \
echo -n 'Torrentino HD (Cartoonchaos):      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-cc.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-cc.sha1" && \
echo -n 'Torrentino HD (Novo StreamFab):    ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-fab.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-fab.sha1" && \
echo -n 'Torrentino HD (HD Ready):          ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-ready.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-ready.sha1" && \
echo -n 'Torrentino HD (widescreen rips):   ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-wide.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1"
rm -r "${SCRIPT_DIR}/files"
