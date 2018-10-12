var o = artifacts.require("./helpers/OwnedWalletProxy");

module.exports = function(deployer) {
  let oneEther = 1000000000000000000;
  deployer.deploy(o, { value: oneEther });
};
