const path = require('path');
const fs = require('fs');
const solc = require('solc');

const inboxpath = path.resolve(__dirname, 'contracts', 'Inbox.sol');
const source = fs.readFileSync(inboxpath, 'UTF-8');

module.exports = solc.compile(source,1).contracts[':Inbox'];

console.log('compiled')
