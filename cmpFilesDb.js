const fs = require('fs');
const { run, blue, exitWithError, getSuccessMessage } = require('./utils');
const { readFilesDb, formatFilesDbs } = require('./utils/checksum');
const { sync } = require('./utils/set');

const argv = process.argv.slice(2);

const fromArg = argv.indexOf('--from'); // Are files from --from ...
const inArg = argv.indexOf('--in');     // ... present in --in ?
const outArg = argv.indexOf('--out');
const lax = argv.includes('--lax');

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
  const fromDb = await readFilesDb(fromValue);
  const inDb = await readFilesDb(inValue);

  const [syncedFiles, notSyncedFiles] = formatFilesDbs(sync(fromDb, inDb));

  if (notSyncedFiles) {
    const msg = `
      files in the input (--in) database missing from the source (--from) database:

      ${lax ? notSyncedFiles.split('\n').length : notSyncedFiles}
    `;

    if (lax) {
      console.error(msg);
    } else throw new Error(msg);
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
