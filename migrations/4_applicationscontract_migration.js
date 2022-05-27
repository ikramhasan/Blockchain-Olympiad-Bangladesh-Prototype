const ApplicationsContract = artifacts.require("ApplicationsContract");

module.exports = function (deployer) {
    deployer.deploy(ApplicationsContract);
}