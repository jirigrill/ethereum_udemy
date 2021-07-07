const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());

let accounts;

beforeEach(async () => {
  // get a list of all unlocked accounts
  accounts = await web3.eth.getAccounts();

});

describe('Inbox', () => {
  it('deploys contract', () => {
    console.log(accounts);
  });
});
