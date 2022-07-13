const Oracle = artifacts.require('Oracle');
const Consumer = artifacts.require('Consumer');

module.exports = async function (deployer, _network, addresses) {
	const [admin, reporter, _] = addresses;
	await deployer.deploy(Oracle, admin);
	const oracle = await Oracle.deployed();
	await oracle.updateReporter(reporter, true);
	await deployer.deploy(Consumer, oracle.address);
};
