const fs = require('fs');
const https = require('https');
const path = require('path');
const { run } = require('./utils');

let log;

const URLS = [
  /* paste a list of URLs */
];
const DIR_NAME = 'downloaded';

// let's download some stuff...
run(async () => {
  await createLog();

  if (!fs.existsSync(DIR_NAME)) {
    fs.mkdirSync(DIR_NAME);
  }

  await URLS.reduce((acc, url) => {
    return acc.then(() => {
      const fileName = url.split('/').pop();
      return download(url, path.join(DIR_NAME, fileName));
    }).then(() => {
      process.stdout.write('*');
    });
  }, Promise.resolve());
});

async function createLog() {
  log = fs.createWriteStream('downloader.log');
  return new Promise((resolve, reject) => {
    log.on('open', () => {
      resolve();
    });

    log.on('error', reject);
  });
}

function download(url, fileName) {
  let write;

  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      if (res.statusCode !== 200) {
        return reject(
          new Error(
            `Received status code: ${
              res.statusCode
            }, expected 200, for url: ${url}`,
          ),
        );
      }

      log.write(
        `Downloading file with content-type: ${
          res.headers['content-type']
        }...\n`,
      );

      write = fs.createWriteStream(fileName);

      res.pipe(write).on('error', reject);

      write.on('finish', () => {
        resolve();
      });
    });
  }).catch((error) => {
    write?.destroy();

    if (fs.existsSync(fileName)) {
      fs.unlinkSync(fileName);
    }

    throw error;
  });
}
