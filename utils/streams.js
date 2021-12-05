const fs = require('fs');
const { pipeline } = require('stream/promises');
const { addToSet } = require('./set');

/**
 * @param {string} filePath
 * @returns {(mapper: (value: string) => string) => Promise<Set<string>>}
 */
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

/**
 * @param {(value: string) => string} mapper
 */
function applyMapper(mapper) {
  return async function* (read) {
    for await (const line of read) {
      yield mapper(line);
    }
  }
}

module.exports = exports = {
  createReader,
  serialProcess,
  applyMapper,
};
