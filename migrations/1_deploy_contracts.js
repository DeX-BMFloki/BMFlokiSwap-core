const BMFLokiFactory = artifacts.require("BMFLokiFactory");

const { feeToSetter } = require('../secrets.json');

module.exports = async function(deployer) {
  await deployer.deploy(BMFLokiFactory, feeToSetter);
};
