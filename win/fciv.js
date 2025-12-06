const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

const argv = process.argv.slice(2);

const FCIV = '"C:\\Program Files\\Fciv\\fciv.exe"';
const DIST_DIR = path.join(__dirname, '..', '..', 'dist');
const OUT_FILE = path.join(DIST_DIR, 'win-log.txt');

if (!fs.existsSync(DIST_DIR)) fs.mkdirSync(DIST_DIR);

const write = fs.createWriteStream(OUT_FILE);
const cp = spawn(FCIV, argv, {
  shell: true,
  stdio: 'pipe',
});

cp.stdout.pipe(write);
cp.stdout.pipe(process.stdout);
cp.stderr.pipe(process.stderr);
