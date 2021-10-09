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
  console.error(`${red('error')} ${message}`);
  process.exit(1);
}

function exitSuccess() {
  console.log(green('success'));
}

function run(program, ...args) {
  program(...args).catch(handleProcessError);
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
  exitWithError,
  exitSuccess,
};
