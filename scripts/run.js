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

    await waveContract.getSuggestionsByAddress(owner.address);
    await waveContract.getSuggestionsByAddress(randomPerson.address);

    await waveContract.getTokenBullCount("LUNA");

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