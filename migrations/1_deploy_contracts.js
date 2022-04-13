const BMFLokiERC20 = artifacts.require("BMFLokiERC20");

const BMFLokiPair = artifacts.require("BMFLokiPair");

const BMFLokiFactory = artifacts.require("BMFLokiFactory");

const { feeToSetter } = require('../secrets.json');

module.exports = async function(deployer) {
  await deployer.deploy(BMFLokiERC20);
  await deployer.deploy(BMFLokiPair);
  await deployer.deploy(BMFLokiFactory, feeToSetter);
};
