const path = require('path');

function getFileExtension(filePath) {
  const extname = path.extname(filePath);

  if (extname.startsWith('.')) {
    return extname.slice(1);
  }

  return extname;
}

function getFileName(filePath, withExtension = false) {
  const extension = getFileExtension(filePath);

  return path.basename(filePath, withExtension ? undefined : `.${extension}`);
}

module.exports = exports = {
  getFileExtension,
  getFileName
};
