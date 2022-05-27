const CertificatesContract = artifacts.require("CertificatesContract");

module.exports = function (deployer) {
    deployer.deploy(CertificatesContract);
}