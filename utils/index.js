const ESCAPE = '\x1b';
const RED = `${ESCAPE}[31m`;
const GREEN = `${ESCAPE}[32m`;
const BLUE = `${ESCAPE}[34m`;
const YELLOW = `${ESCAPE}[33m`;
const RESET = `${ESCAPE}[0m`;

const red = (value) => [RED, value, RESET].join('');
const green = (value) => [GREEN, value, RESET].join('');
const blue = (value) => [BLUE, value, RESET].join('');
const yellow = (value) => [YELLOW, value, RESET].join('');

function handleProcessError(error) {
  exitWithError(error.message);
}

function exitWithError(message) {
  const msg = 'error';
  console.error(`${isTTY(true) ? red(msg) : msg} ${message}`);
  process.exit(1);
}

function exitSuccess() {
  console.log(getSuccessMessage());
  process.exit(0);
}

function getSuccessMessage(noColor = false) {
  const msg = 'success';
  return isTTY() && !noColor ? green(msg) : msg;
}

function run(program, ...args) {
  program(...args).catch(handleProcessError);
}

/**
 * @param {boolean} checkStderr
 */
function isTTY(checkStderr) {
  return Boolean(
    checkStderr ? process.stderr.isTTY : process.stdout.isTTY
  );
}

/**
 * @param {string[]} warnings
 */
function printWarnings(warnings, pad = true) {
  if (!warnings.length) return;

  if (pad) console.log();

  warnings.forEach((warning) => {
    if (warning) {
      console.log(`${yellow('WARNING')} ${warning}`);
    }
  });

  if (pad) console.log();
}

module.exports = exports = {
  ESCAPE,
  RED,
  GREEN,
  RESET,
  red,
  green,
  blue,
  run,
  handleProcessError,
  getSuccessMessage,
  isTTY,
  printWarnings,
  exitWithError,
  exitSuccess,
};
