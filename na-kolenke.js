const fs = require('fs');
const { pipeline } = require('stream/promises');
const { run, exitWithError } = require('./utils');

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
        filesList
      }`,
    );
  }

  console.log(syncedFiles);
});

async function readFilesDb(filesDbPath) {
  return createReader(filesDbPath)(v => v);
}

function readChecksumDb(checksumDbPath) {
  return createReader(checksumDbPath)(checksumToFilename);
}

/**
 * @param {string} checksumLine
 * @returns {string}
 */
function checksumToFilename(checksumLine) {
  const [checksum, ...nameParts] = checksumLine.split(' ');
  const fileName = nameParts.join(' ');

  if (fileName.length === 0) {
    throw new Error(
      `empty file at checksum "${checksum ?? '<empty>'}"`,
    );
  }

  return fileName;
}

function createReader(filePath) {
  return async function(mapper) {
    const set = new Set();
    const read = fs.createReadStream(filePath, {
      encoding: 'utf8',
    });

    await pipeline(
      read,
      serialProcess,
      applyMapper(mapper),
      addToSet(set),
    );

    return set;
  }
}

async function* serialProcess(read) {
  let last = '';

  for await (const chunk of read) {
    last += chunk;

    const lines = last.split('\n');

    last = lines.pop();

    yield* lines;
  }

  if (last.length > 0) yield last;
}

function applyMapper(mapper) {
  return async function* (read) {
    for await (const line of read) {
      yield mapper(line);
    }
  }
}

function addToSet(set) {
  return async function(read) {
    for await (const file of read) {
      set.add(file);
    }
  };
}
