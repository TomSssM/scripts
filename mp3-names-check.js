const fs = require('fs');
const { run, blue, yellow, bold, getSuccessMessage } = require('./utils');
const { getFileName } = require('./utils/path');

const TRACK_NAME_SEPARATOR = '. ';

const info = [];
const warnings = [];

const argv = process.argv.slice(2);

const [ mediaInfoFile ] = argv;

if (['--help', '-h', 'help', 'h'].includes(argv[0])) {
  console.log(`
${blue('running:')} ${bold('node mp3-names-check.js ./mediainfo.json')}

${blue('gives you all the mismatches between file names and song names in the form:')}
    warning: Mismatch:
    "<track-title>" !== "<file-name>"
    at "file-path"
  `.trim());

  process.exit(0);
}

run(async () => {
  if (!mediaInfoFile) {
    throw new Error('No mediainfo.json file passed');
  }

  const mediaInfoString = fs.readFileSync(mediaInfoFile, { encoding: 'utf8' });
  const mediaInfo = JSON.parse(mediaInfoString);

  processMediaInfo(mediaInfo);

  fs.writeFileSync('warnings.log', getWarnings(), { encoding: 'utf8' });

  console.log(`${blue('all warnings written to:')} warnings.log`);
  console.log(getSuccessMessage());
});

function processMediaInfo(mediaInfo) {
  for (const item of mediaInfo) {
    processItem(item);
  }

  processInfo();
}

function processItem(item) {
  const {
    media: {
      ['@ref']: filePath,
      track: [
        {
          Title: title,
          Track: trackName
        }
      ]
    }
  } = item;

  if (title !== trackName) {
    throw new Error(`Title doesn't match Track Name at ${filePath}`);
  }

  processFilePath(filePath);
  processTrackName(trackName);
}

function processFilePath(filePath) {
  const trackNameFromFileName = getTrackNameFromFileName(getFileName(filePath, false));

  info.push({
    filePath,
    trackNameFromFileName,
    trackName: null
  });
}

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

function processTrackName(trackName) {
  info.at(-1).trackName = trackName;
}

function processInfo() {
  for (const { filePath, trackName, trackNameFromFileName } of info) {
    if (trackName !== trackNameFromFileName) {
      warning(
        'Mismatch:',
        `"${trackName}" !== "${trackNameFromFileName}"`,
        `at "${filePath}"`
      );
    }

    if (trackName !== trackName.trim()) {
      warning(
        'Track name has extra spaces',
        `at "${filePath}"`
      );
    }

    if (trackNameFromFileName !== trackNameFromFileName.trim()) {
      warning(
        'File name has extra spaces',
        `at "${filePath}"`
      );
    }
  }
}

function warning(...messages) {
  const message = [
    ...messages,
    '', '', ''
  ].join('\n');

  warnings.push(message);
  console.warn(`${yellow('warning:')} ${message}`);
}

function getWarnings() {
  if (warnings.length === 0) {
    return '';
  }

  return warnings.join('\n').trim() + '\n';
}
