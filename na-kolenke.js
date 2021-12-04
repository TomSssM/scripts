const { run, exitWithError, getSuccessMessage } = require('./utils');
const { readChecksumDb, readFilesDb } = require('./utils/checksum');

const argv = process.argv.slice(2);

const checksumArg = argv.indexOf('--checksum'); // we got it
const filesArg = argv.indexOf('--files'); // create it via find <path> -type f > <out>

const checksumPath = argv[checksumArg + 1];
const filesPath = argv[filesArg + 1];

if (!checksumPath || !filesPath) {
  exitWithError('not enough arguments');
}

run(async () => {
  const filesDb = await readFilesDb(filesPath);
  const files = filesDb.values();
  const checksumDb = await readChecksumDb(checksumPath);
  const newFiles = [];

  for (const file of files) {
    if (!checksumDb.has(file)) {
      newFiles.push(file);
    } else {
      checksumDb.delete(file);
    }
    filesDb.delete(file);
  }

  const [notSyncedFiles, syncedFiles] = [
    Array.from(checksumDb.values()), newFiles,
  ].map((arr) => arr.join('\n'));

  if (notSyncedFiles) {
    throw new Error(
      `files in checksum database missing in the file system: \n${
        notSyncedFiles
      }`,
    );
  }

  console.log(syncedFiles || getSuccessMessage());
});
