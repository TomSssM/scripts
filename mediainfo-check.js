const fs = require('fs');
const { run, blue, yellow, bold, getSuccessMessage } = require('./utils');
const { createReader, applyMapper } = require('./utils/streams');

const argv = process.argv.slice(2);

if (['--help', '-h', 'help', 'h'].includes(argv[0])) {
  console.log(`
${blue('running:')} ${bold('node mediainfo-check.js ./mediainfo.txt')}

${blue('gives you aggregated mediainfo of the form:')}
    {
      Group: {
        Title: [
          <occurences-count>,
          ...unique values
        ]
      }
    }
  `.trim());

  process.exit(0);
}

const [ mediaInfoFile ] = argv;

run(async () => {
  if (!mediaInfoFile) {
    throw new Error('No mediainfo.txt file passed');
  }

  await createReader(
    applyMapper(processLine)
  )(mediaInfoFile);

  fs.writeFileSync('warnings.log', getWarnings(), { encoding: 'utf8' });
  fs.writeFileSync('mediainfo.json', getInfo(), { encoding: 'utf8' });

  console.log(`${blue('all data written to:')} mediainfo.json`);
  console.log(getSuccessMessage());
});

class MediaInfoFormatError extends Error {
  constructor(message) {
    super(`MediaInfo wrong format error: ${message}`);
  }
}

const warnings = [];

function getWarnings() {
  if (warnings.length === 0) {
    return '';
  }

  return warnings.join('\n') + '\n';
}

function warning(message) {
  warnings.push(message);
  console.warn(`${yellow('warning:')} ${message}`);
}

function getInfo() {
  return JSON.stringify(info, null, 4) + '\n';
}

const MEDIAINFO_SEPARATOR = ':';
const UNIQUE_TITLES = [
  'Unique ID',
  'Complete name'
];

const info = {};
let isFirstFile = true;
let currentFile = null;
let currentGroup = null;

async function processLine(line) {
  if (line === '') {
    return;
  }

  let [title, ...parts] = line.split(MEDIAINFO_SEPARATOR);
  let value = parts.join(MEDIAINFO_SEPARATOR);

  title = title.trim();
  value = value.trim();

  if (!title) {
    throw new MediaInfoFormatError('No title found');
  }

  if (value === '') {
    currentGroup = title;

    if (!info[currentGroup]) {
      info[currentGroup] = {};
    }

    return;
  }

  if (title === 'Unique ID') {
    if (currentFile !== null) {
      isFirstFile = false;
    }

    currentFile = value;
  }

  if (title && value && !currentGroup) {
    throw new MediaInfoFormatError(`No group for title ${title}: ${value}`);
  }

  if (title && value && !currentFile) {
    throw new MediaInfoFormatError(`No 'Unique ID' title found before ${title}: ${value}`);
  }

  if (!info[currentGroup][title]) {
    info[currentGroup][title] = [];
  }

  let [count = 0, ...occurences] = info[currentGroup][title];

  if (count === 0 && !isFirstFile) {
    warning(`${currentFile} is adding a new title: ${currentGroup} > ${title}: ${value}`);
  }

  info[currentGroup][title][0] = count + 1;

  if (!UNIQUE_TITLES.includes(title) && !occurences.includes(value)) {
    info[currentGroup][title].push(value);
  }
}
