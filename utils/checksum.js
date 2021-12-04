const { createReader } = require('./streams');

async function readFilesDb(filesDbPath) {
  return createReader(filesDbPath)(v => v);
}

function readChecksumDb(checksumDbPath) {
  return createReader(checksumDbPath)(checksumToFilename);
}

const CHECKSUM_SEPARATOR = '  ';

/**
 * @param {string} checksumLine
 * @returns {[string, string]}
 */
function parseChecksum(checksumLine) {
  const [checksum = null, ...nameParts] = checksumLine.split(CHECKSUM_SEPARATOR);
  const fileName = nameParts.join(CHECKSUM_SEPARATOR);

  if (fileName.length === 0) {
    throw new Error(
      `empty file at checksum "${checksum || '<empty>'}"`,
    );
  }

  return [fileName, checksum || null];
}

/**
 * @param {string} checksumLine
 * @returns {string}
 */
function checksumToFilename(checksumLine) {
  return parseChecksum(checksumLine)[0];
}

module.exports = exports = {
  CHECKSUM_SEPARATOR,
  readFilesDb,
  readChecksumDb,
  checksumToFilename,
};
