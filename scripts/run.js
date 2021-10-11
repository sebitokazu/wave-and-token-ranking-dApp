const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to: ", waveContract.address);
    console.log('Contract deployed by:', owner.address);

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();
  
    waveCount = await waveContract.getTotalWaves();

    lunaBullTxn = await waveContract.bullToken("LUNA");
    await lunaBullTxn.wait();

    lunaBullTxn2 = await waveContract.connect(randomPerson).bullToken("LUNA");
    await lunaBullTxn2.wait();

    ethBullTxn = await waveContract.bullToken("ETH");
    await ethBullTxn.wait();

    await waveContract.getTokenBullCount("LUNA");

    const {0: tokenArray,1: tokenCount} = await waveContract.getAllTokenBullCount();
    tokenArray.forEach((element,idx) => {
        console.log("%s token has %d votes", element, tokenCount[idx]);
    });


};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();