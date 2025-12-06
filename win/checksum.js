const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const FCIV = path.join(__dirname, 'fciv.js');
const [directoryPath] = process.argv.slice(2);

try {
  if (fs.existsSync(directoryPath)) {
    if (/\s/.test(directoryPath)) {
      throw new Error(
        `fciv.exe doesnt understand difficult characters in path names: "${directoryPath}"`,
      );
    }
    execFileSync('node', [FCIV, '-r', '-sha1', path.normalize(directoryPath)], {
      stdio: 'inherit',
    });
  } else {
    throw new Error(`Wrong path: "${directoryPath}"`);
  }
} catch (error) {
  console.error(error.message);
  process.exit(1);
}
