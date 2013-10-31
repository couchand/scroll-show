// scroll-show main

var fs = require('fs');
var scrollShow = require('./src/scroll-show');

function main(argv) {
  if (!argv[1]) {
    console.log("Usage: node "+argv[0]+" URL_FILE");
    return;
  }

  var urls = fs.readFileSync(argv[1])
    .toString()
    .split('\n')
    .map(function(s) { return s.trim(); })
    .filter(function(s) { return s != ''; });

  scrollShow(urls);
}

main(process.argv.slice(1));
