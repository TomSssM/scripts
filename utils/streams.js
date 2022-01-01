const fs = require('fs');
const { pipeline } = require('stream/promises');
const { addToSet } = require('./set');
const { addToMap } = require('./map');

/**
 * @param {Array<(readable) => AsyncGenerator<string, void, undefined>>} mapGenerators
 * @returns {(filePath: string) => Promise<void>}
 */
function createReader(...mapGenerators) {
  return async function(filePath) {
    const read = fs.createReadStream(filePath, {
      encoding: 'utf8',
    });

    await pipeline(
      read,
      serialProcess,
      ...mapGenerators
    );
  }
}

/**
 * @param {string} filePath
 * @returns {(mapper: (value: string) => string) => Promise<Set<string>>}
 */
function createSetReader(filePath) {
  return async function(mapper) {
    const set = new Set();

    await createReader(
      applyMapper(mapper),
      addToSet(set)
    )(filePath);

    return set;
  }
}

/**
 * @param {string} filePath
 * @returns {(mapper: (value: string) => [key: string, value: string]) => Promise<Map<string, string[]>>}
 */
function createMapReader(filePath) {
  return async function(mapper) {
    const map = new Map();

    await createReader(
      applyMapper(mapper),
      addToMap(map)
    )(filePath);

    return map;
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

/**
 * @param {<V extends string | string[]>(value: string) => V} mapper
 */
function applyMapper(mapper) {
  return async function* (read) {
    for await (const line of read) {
      yield mapper(line);
    }
  }
}

module.exports = exports = {
  createSetReader,
  createMapReader,
  serialProcess,
  applyMapper,
};
