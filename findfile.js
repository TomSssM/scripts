#!/usr/bin/env node

const fs = require('fs');
const { pipeline } = require('stream/promises');

if (require.main === module) {
  const [file1, file2] = process.argv.slice(2);
  main(file1, file2).catch(handleProcessError);
}

const ESCAPE = '\x1b';
const RED = `${ESCAPE}[31m`;
const GREEN = `${ESCAPE}[32m`;
const RESET = `${ESCAPE}[0m`;

const red = (value) => [RED, value, RESET].join('');
const green = (value) => [GREEN, value, RESET].join('');

async function main(file1, file2) {
  const oldDb = await readDb(file1);
  const newDb = await readDb(file2);

  for (const file of newDb.values()) {
    if (!oldDb.has(file)) {
        console.log(green(`+ ${file}`));
    } else {
      oldDb.delete(file);
    }
    newDb.delete(file);
  }

  for (const file of oldDb.values()) {
    console.log(red(`- ${file}`));
  }
}

function handleProcessError(error) {
  console.error(`${red('error')} ${error.message}`);
  process.exit(1);
}

async function readDb(filepath) {
  const set = new Set();
  const read = fs.createReadStream(filepath, {
    encoding: 'utf8',
  });

  await pipeline(
    read,
    serialProcess,
    async function* (pipe) {
      for await (const file of pipe) {
        set.add(file);
      }
    },
  );

  return set;
}

async function* serialProcess(chunks) {
  let last = '';

  for await (const chunk of chunks) {
    last += chunk;

    const lines = last.split('\n');

    last = lines.pop();

    yield* lines;
  }

  if (last.length > 0) yield last;
}

exports.findfile = main;
