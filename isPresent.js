const fs = require('fs');
const { run, exitWithError, blue, getSuccessMessage } = require('./utils');
const { readChecksumDbToMap, serializeChecksumMapDb } = require('./utils/checksum');
const { diff } = require('./utils/map');

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
    const [diffMap, correspondsMap] = diff(fromDb, inDb).map((db) => serializeChecksumMapDb(db) || '...empty');

    const msg = `

DIFF:
${diffMap}

CORRESPONDS:
${correspondsMap}

`;

    if (outValue) {
      fs.writeFileSync(outValue, msg.trim() + '\n', { encoding: 'utf8' });
      console.log(`${blue('all data written to:')} ${outValue}`);

      return console.log(getSuccessMessage());
    }

    // if (missingChecksums) {
    //   throw new Error(`
    //     missing checksums:

    //     ${missingChecksums}
    //   `);
    // }

    console.log(msg);
    console.log(getSuccessMessage());
});
