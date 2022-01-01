const { createSetReader, createMapReader } = require('./streams');

/**
 * @param {string} filesDbPath
 * @returns {Promise<Set<string>>}
 */
async function readFilesDb(filesDbPath) {
  return createSetReader(filesDbPath)(v => v);
}

/**
 * @param {string} checksumDbPath
 * @returns {Promise<Set<string>>}
 */
async function readChecksumDbToSet(checksumDbPath) {
  return createSetReader(checksumDbPath)(checksumToFilename);
}

/**
 * @param {string} checksumDbPath
 * @returns {Promise<Map<string, string[]>>}
 */
async function readChecksumDbToMap(checksumDbPath) {
  return createMapReader(checksumDbPath)(parseChecksum);
}

const CHECKSUM_SEPARATOR = '  ';

/**
 * @param {string} checksumLine
 * @returns {[checksum: string, fileName: string]}
 */
function parseChecksum(checksumLine) {
  const [checksum = null, ...nameParts] = checksumLine.split(CHECKSUM_SEPARATOR);
  const fileName = nameParts.join(CHECKSUM_SEPARATOR);

  if (fileName.length === 0) {
    throw new Error(
      `empty file at checksum "${checksum || '<empty>'}"`,
    );
  }

  if (!checksum) {
    throw new Error(
      `empty checksum at file name "${fileName || '<empty>'}"`,
    );
  }

  return [checksum || null, fileName];
}

/**
 * @param {string} checksum
 * @param {string} fileName
 * @returns {string}
 */
function serializeChecksum(checksum, fileName) {
  return [checksum, fileName].join(CHECKSUM_SEPARATOR);
}

/**
 * @param {string} checksumLine
 * @returns {string}
 */
function checksumToFilename(checksumLine) {
  return parseChecksum(checksumLine)[1];
}

/**
 * @param {[Set<string>, Set<string>]}
 * @returns {[string, string]}
 */
function formatFilesDbs([syncedDb, notSyncedDb]) {
  return [syncedDb, notSyncedDb].map((db) => Array.from(db).join('\n'));
}

/**
 * @param {Map<string, string[]>} db
 */
function serializeChecksumMapDb(db) {
  const out = [];

  for (const [checksum, files] of db.entries()) {
    out.push(...files.map(
      (file) => serializeChecksum(checksum, file)
    ));
  }

  return out.join('\n');
}

/**
 * @param {[Map<string, string[]>, Map<string, string[]>]}
 * @returns {[string, string]}
 */
function formatChecksumDbs([syncedDb, notSyncedDb]) {
  return [syncedDb, notSyncedDb].map((db) => serializeChecksumMapDb(db));
}

module.exports = exports = {
  CHECKSUM_SEPARATOR,
  readFilesDb,
  parseChecksum,
  readChecksumDbToSet,
  readChecksumDbToMap,
  checksumToFilename,
  formatFilesDbs,
  formatChecksumDbs,
};
