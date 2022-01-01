const fs = require('fs');
const { run, exitWithError, blue, getSuccessMessage } = require('./utils');
const { readChecksumDbToMap, formatChecksumDbs } = require('./utils/checksum');
const { sync } = require('./utils/map');

const argv = process.argv.slice(2);

const fromArg = argv.indexOf('--from'); // Are checksums from --from ...
const inArg = argv.indexOf('--in');     // ... present in --in ?
const outArg = argv.indexOf('--out');

if (fromArg === -1 || inArg === -1) {
    exitWithError(
      `not enough arguments:
        Are file checksums from ${blue('--from')} ... present in ${blue('--in')} ... ?
      `
    );
}

const fromValue = argv[fromArg + 1];
const inValue = argv[inArg + 1];
const outValue = outArg !== -1 && argv[outArg + 1];

/**
 * similar to cmpFilesDb @see cmpFilesDb.js
 */
run(async () => {
    const inDb = await readChecksumDbToMap(inValue);
    const fromDb = await readChecksumDbToMap(fromValue);
    const [syncedChecksums, notSyncedChecksums] = formatChecksumDbs(sync(inDb, fromDb));

    if (notSyncedChecksums) {
        throw new Error(`
          checksums in the source (--from) database missing from the input (--in) database:

          ${notSyncedChecksums}
        `);
    }

    if (outValue) {
        const data = syncedChecksums || getSuccessMessage(true);
        fs.writeFileSync(outValue, data + '\n', { encoding: 'utf8' });

        if (syncedChecksums) {
            console.log(`${blue('all files diff written to:')} ${outValue}`);
        }

        return console.log(getSuccessMessage());
    }

    console.log(syncedChecksums || getSuccessMessage());
});
