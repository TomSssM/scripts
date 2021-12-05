/**
 * @param {Set<string>} set
 */
function addToSet(set) {
  return async function(read) {
    for await (const file of read) {
      set.add(file);
    }
  };
}

/**
 * return values of set1 missing from set2
 * @param {Set<string>} set1
 * @param {Set<string>} set2
 * @returns {Set<string>}
 */
function diff(set1, set2) {
  const diffSet = new Set();

  for (const value1 of set1.values()) {
    if (!set2.has(value1)) {
      diffSet.add(value1);
    }
  }

  return diffSet;
}

/**
 * checks what values of set1 are missing from set2 and
 * additionally returns values of set2 missing from set1
 *
 * @param {Set<string>} set1
 * @param {Set<string>} set2
 * @returns {[Set<string>, Set<string>]}
 */
function sync(set1, set2) {
  const diff1 = diff(set1, set2);
  const diff2 = diff(set2, set1);

  return [diff1, diff2];
}

module.exports = exports = {
  addToSet,
  diff,
  sync,
};
