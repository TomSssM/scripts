const { createReader } = require('./streams');

/**
 * @param {string} filesDbPath
 * @returns {Promise<Set<string>>}
 */
async function readFilesDb(filesDbPath) {
  return createReader(filesDbPath)(v => v);
}

/**
 * @param {string} filesDbPath
 * @returns {Promise<Set<string>>}
 */
async function readChecksumDb(checksumDbPath) {
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

/**
 * @param {[Set<string>, Set<string>]}
 * @returns {[string, string]}
 */
function formatFilesDbs([syncedDb, notSyncedDb]) {
  return [syncedDb, notSyncedDb].map((db) => Array.from(db).join('\n'));
}

module.exports = exports = {
  CHECKSUM_SEPARATOR,
  readFilesDb,
  readChecksumDb,
  checksumToFilename,
  formatFilesDbs,
};
