// const { diff: setDiff } = require('./set');

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
 * @returns {[diffMap: Map<string, string[]>, correspondsMap: Map<string, string[]>]}
 */
function diff(map1, map2) {
  const diffMap = new Map();
  const correspondsMap = new Map();

  const setCorresponds = (file1, file2) => {
    if (file1 === file2) return;

    const k = `${file1} =>`;
    const v = correspondsMap.get(k) ?? [];
    v.push(file2);
    correspondsMap.set(k, v);
  };

  for (const [k, v1] of map1.entries()) {
    const v2 = map2.get(k);

    if (!v2 && v1.length) {
      diffMap.set(k, v1);
    } else if (v1.length && v2.length) {

      if (
        v1.length !== v2.length ||
        v1.some((file) => !v2.includes(file)) ||
        v2.some((file) => !v1.includes(file))
      ) {} else continue;

      const v1Copy = [...v1];
      const v2Copy = [...v2];

      let file1;
      let file2;

      while (v1Copy.length) {
        file1 = v1Copy.shift();
        file2 = v2Copy.shift();

        if (file2) {
          setCorresponds(file1, file2);
        } else {
          setCorresponds(file1, '<COPIED>');
        }
      }

      if (v2Copy.length) {
        v2Copy.forEach((file2) => {
          setCorresponds('<MISSING>', file2);
        });
      }

      // const valuesDiff = Array.from(setDiff(
      //   new Set(v1),
      //   new Set(v2)
      // ));

      // if (valuesDiff.length) {
      //   diffMap.set(k, valuesDiff);
      // }
    }
  }

  return [diffMap, correspondsMap];
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
