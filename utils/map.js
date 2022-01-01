const { diff: setDiff } = require('./set');

/**
 * @param {Map<string, string[]>} map
 * @returns {(read: AsyncGenerator<[key: string, value: string]>) => Map<string, string[]>}
 */
function addToMap(map) {
  return async function (read) {
    for await (const [k, v] of read) {
      const prev = map.get(k) ?? [];
      prev.push(v);
      map.set(k, prev);
    }
  }
}

/**
 * return values of map1 missing from map2
 * @param {Map<string, string[]>} map1
 * @param {Map<string, string[]>} map2
 * @returns {Map<string, string[]>}
 */
function diff(map1, map2) {
  const diffMap = new Map();

  for (const [k, v1] of map1.entries()) {
    const v2 = map2.get(k);

    if (!v2 && v1.length) {
      diffMap.set(k, v1);
    } else if (v1.length && v2.length) {
      const valuesDiff = Array.from(setDiff(
        new Set(v1),
        new Set(v2)
      ));

      if (valuesDiff.length) {
        diffMap.set(k, valuesDiff);
      }
    }
  }

  return diffMap;
}

/**
 * checks what values of map1 are missing from map2 and
 * additionally returns values of map2 missing from map1
 *
 * @param {Map<string, string[]>} map1
 * @param {Map<string, string[]>} map2
 * @returns {[diff1: Map<string, string[]>, diff2: Map<string, string[]>]}
 */
function sync(map1, map2) {
  const diff1 = diff(map1, map2);
  const diff2 = diff(map2, map1);

  return [diff1, diff2];
}

exports.addToMap = addToMap;

exports.diff = diff;

exports.sync = sync;
