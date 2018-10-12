var h = artifacts.require("./helpers/Hacker");

module.exports = function(deployer) {
  let oneEther = 1000000000000000000;
    deployer.deploy(h, { value: oneEther });
};
