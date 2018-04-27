var OdinCoin=artifacts.require("./OdinCoin.sol");

module.exports = function(deployer,network,accounts) {
  const ReserveAccount=web3.eth.accounts[0];
  const KYCAdmin=web3.eth.accounts[0];

  deployer.deploy(OdinCoin,ReserveAccount);
}


