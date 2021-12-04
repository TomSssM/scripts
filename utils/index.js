const ESCAPE = '\x1b';
const RED = `${ESCAPE}[31m`;
const GREEN = `${ESCAPE}[32m`;
const RESET = `${ESCAPE}[0m`;

const red = (value) => [RED, value, RESET].join('');
const green = (value) => [GREEN, value, RESET].join('');

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

function getSuccessMessage() {
  const msg = 'success';
  return isTTY() ? green(msg) : msg;
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

module.exports = exports = {
  ESCAPE,
  RED,
  GREEN,
  RESET,
  red,
  green,
  run,
  handleProcessError,
  getSuccessMessage,
  isTTY,
  exitWithError,
  exitSuccess,
};
