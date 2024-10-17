const fs = require('fs');
const { run, blue, yellow, bold, getSuccessMessage } = require('./utils');
const { createReader, applyMapper } = require('./utils/streams');
const { getFileName } = require('./utils/path');

const argv = process.argv.slice(2);

if (['--help', '-h', 'help', 'h'].includes(argv[0])) {
  console.log(`
${blue('running:')} ${bold('node mp3-names-check.js ./mediainfo.txt')}

${blue('gives you all the mismatches between file names and song names in the form:')}
    TODO
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

  processInfo();

  fs.writeFileSync('warnings.log', getWarnings(), { encoding: 'utf8' });

  console.log(`${blue('all warnings written to:')} warnings.log`);
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

  return warnings.join('\n').trim() + '\n';
}

function warning(message) {
  warnings.push(message);
  console.warn(`${yellow('warning:')} ${message}`);
}

const MEDIAINFO_SEPARATOR = ':';
const TRACK_NAME_SEPARATOR = '. ';

const info = [];

/**
 * Extracts track name from file name
 *
 * @example
 * Track Name => Track Name
 * 01. Track Name => Track Name
 * 1-01. Track Name => Track Name
 */
function getTrackNameFromFileName(fileName) {
  const [, ...parts] = fileName.split(TRACK_NAME_SEPARATOR);

  if (parts.length === 0) {
    return fileName;
  }

  return parts.join(TRACK_NAME_SEPARATOR);
}

function processFilePath(filePath) {
  const trackNameFromFileName = getTrackNameFromFileName(getFileName(filePath, false));

  info.push({
    filePath,
    trackNameFromFileName,
    trackName: null
  });
}

function processTrackName(trackName) {
  info.at(-1).trackName = trackName;
}

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

  if (title === 'Complete name') {
    processFilePath(value);
  }

  if (title === 'Track name') {
    processTrackName(value);
  }
}

function processInfo() {
  for (const { filePath, trackName, trackNameFromFileName } of info) {
    if (trackName !== trackNameFromFileName) {
      warning([
        'Mismatch:',
        `"${trackName}" !== "${trackNameFromFileName}"`,
        `at "${filePath}"`,
        '', '', ''
      ].join('\n'));
    }
  }
}
