const fs = require('fs');
const { run, blue, exitWithError, getSuccessMessage } = require('./utils');
const { readFilesDb, formatFilesDbs } = require('./utils/checksum');
const { sync } = require('./utils/set');

const argv = process.argv.slice(2);

const fromArg = argv.indexOf('--from'); // Are checksums from --from ...
const inArg = argv.indexOf('--in');     // ... present in --in ?
const outArg = argv.indexOf('--out');

/**
 * --from
 * [
 *   1, 2, 3, 4
 * ]
 *
 * --in
 * [
 *   1, 2, 3, a, b, c
 * ]
 *
 * not synced: 4
 * synced: a, b, c
 */

const fromValue = argv[fromArg + 1];
const inValue = argv[inArg + 1];
const outValue = outArg !== -1 && argv[outArg + 1];

if (fromArg === -1 || inArg === -1) {
  exitWithError(
    `not enough arguments:
      Are files from --from ... present in --in ... ?
    `
  );
}

run(async () => {
  const inDb = await readFilesDb(inValue);
  const fromDb = await readFilesDb(fromValue);
  const [syncedFiles, notSyncedFiles] = formatFilesDbs(sync(inDb, fromDb));

  if (notSyncedFiles) {
    throw new Error(`
      files in the source (--from) database missing from the input (--in) database:

      ${notSyncedFiles}
    `);
  }

  if (outValue) {
    const data = syncedFiles || getSuccessMessage(true);
    fs.writeFileSync(outValue, data + '\n', { encoding: 'utf8' });

    if (syncedFiles) {
      console.log(`${blue('all files diff written to:')} ${outValue}`);
    }

    return console.log(getSuccessMessage());
  }

  console.log(syncedFiles || getSuccessMessage());
});
