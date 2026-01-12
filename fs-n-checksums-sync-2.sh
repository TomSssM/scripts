SCRIPT_DIR=$(pwd)
CHECKSUMS_DIR=$(realpath "${SCRIPT_DIR}/../checksums-2")
if [ -d "${SCRIPT_DIR}/files" ]; then
  rm -r "${SCRIPT_DIR}/files"
fi
mkdir "${SCRIPT_DIR}/files" && \
mkdir "${SCRIPT_DIR}/files/files" && \
mkdir "${SCRIPT_DIR}/files/checksums" && \
cd "${DRIVE}/Buffer" && \
find './Main' -type f >> "${SCRIPT_DIR}/files/files/main.txt" && \
find './Updates' -type f >> "${SCRIPT_DIR}/files/files/updates.txt" && \
find './Torrentino' -type f >> "${SCRIPT_DIR}/files/files/torrentino.txt" && \
find './Torrentino HD/Cartoonchaos' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-cc.txt" && \
find './Torrentino HD/HD Ready' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-ready.txt" && \
find './Torrentino HD/Novo StreamFab' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-fab.txt" && \
find './Torrentino HD/Storage HD' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-storage-hd.txt" && \
find './Torrentino HD/widescreen rips' -type f >> "${SCRIPT_DIR}/files/files/torrentino-hd-wide.txt" && \
cd "${CHECKSUMS_DIR}" && \
find './db/sha1' -path './db/sha1/main.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/main.sha1" && \
find './db/sha1' -path './db/sha1/updates-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/updates.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-legacy-stuff-main-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-legacy-stuff-torrent.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-misc.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-new.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-old-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-other-cartoons-cartoons.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-other-cartoons-dvb.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-cc-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-cc.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-ready-dvd-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-ready.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-ready-special-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-ready.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-fab-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-fab.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-storage-hd-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-storage-hd.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-cc.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-dht-*.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-localized.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-rutracker.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-scripts.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
find './db/sha1' -path './db/sha1/torrentino-hd-wide-unsorted.sha1' -exec cat {} \; >> "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
cd "${SCRIPT_DIR}" && \
echo && \
echo -n 'Main:                                                          ' && cat "${SCRIPT_DIR}/files/files/main.txt" | wc -l && \
echo -n 'Updates:                                                       ' && cat "${SCRIPT_DIR}/files/files/updates.txt" | wc -l && \
echo -n 'Torrentino:                                                    ' && cat "${SCRIPT_DIR}/files/files/torrentino.txt" | wc -l && \
echo -n 'Torrentino HD (Cartoonchaos):                                  ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-cc.txt" | wc -l && \
echo -n 'Torrentino HD (HD Ready):                                      ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-ready.txt" | wc -l && \
echo -n 'Torrentino HD (Novo StreamFab):                                ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-fab.txt" | wc -l && \
echo -n 'Torrentino HD (Storage HD):                                    ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-storage-hd.txt" | wc -l && \
echo -n 'Torrentino HD (widescreen rips):                               ' && cat "${SCRIPT_DIR}/files/files/torrentino-hd-wide.txt" | wc -l && \
echo && \
echo -n 'Main:                                                          ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/main.txt" --checksum "${SCRIPT_DIR}/files/checksums/main.sha1" && \
echo -n 'Updates:                                                       ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/updates.txt" --checksum "${SCRIPT_DIR}/files/checksums/updates.sha1" && \
echo -n 'Torrentino:                                                    ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino.sha1" && \
echo -n 'Torrentino HD (Cartoonchaos):                                  ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-cc.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-cc.sha1" && \
echo -n 'Torrentino HD (HD Ready):                                      ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-ready.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-ready.sha1" && \
echo -n 'Torrentino HD (Novo StreamFab):                                ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-fab.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-fab.sha1" && \
echo -n 'Torrentino HD (Storage HD):                                    ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-storage-hd.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-storage-hd.sha1" && \
echo -n 'Torrentino HD (widescreen rips):                               ' && node na-kolenke.js --files "${SCRIPT_DIR}/files/files/torrentino-hd-wide.txt" --checksum "${SCRIPT_DIR}/files/checksums/torrentino-hd-wide.sha1" && \
rm -r "${SCRIPT_DIR}/files"
