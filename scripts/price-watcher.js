const CoinGecko = require('coingecko-api');
const Oracle = artifacts.require('Oracle.sol');

const POLL_INTERVAL = 5000;

const client = new CoinGecko();

module.exports = async done => {
	const [_, reporter] = await web3.eth.getAccounts();
	const oracle = await Oracle.deployed();
	while (true) {
		const res = await client.coins.fetch('bitcoin', {});
		let currentPrice = parseFloat(res.data.market_data.current_price.usd);
		currentPrice = parseInt(currentPrice * 100);
		await oracle.updateData(web3.utils.soliditySha3('BTC/USD'), currentPrice, {
			from: reporter,
		});
		console.log(`Updated price to ${currentPrice}`);
		await new Promise(resolve => setTimeout(resolve, POLL_INTERVAL));
	}
	done();
};
