const { makeTransferProxyAdminOwnership } = require("@openzeppelin/hardhat-upgrades/dist/admin");
const { expect, util } = require("chai");
const { utils, Signer } = require("ethers");
const { ethers, upgrades } = require("hardhat");
//const { web3 } = require("@openzeppelin/test-envionment")

describe("Deployer", function () {
  it("should deploy", async function () {
    const Mprox = await ethers.getContractFactory("MasterProxy"); 
    const Uprox = await ethers.getContractFactory("UpgradableProxy")
    const Ulog = await ethers.getContractFactory("UpgradableLogic")

    let accounts = await hre.ethers.getSigners();
    console.log("Here")
    const mprox = await Mprox.deploy();
    console.log("Here")
   // await mprox.deployed();
    const uprox = await Uprox.deploy()
    //const uprox = await Uprox.deploy("0.1")
    const ulog = await Ulog.deploy()



    await mprox.deployed();
    await uprox.deployed();
   await ulog.deployed();

    
    
    await uprox.setLogicAddress(ulog.address);

    const addr = await uprox.getAddress();

    console.log("Log address: " + ulog.address)
    console.log(addr);

    abi = [
      "function hello() public",
      "function getInt() public view returns(uint256)",
    ]

    const proxied =  new ethers.Contract(uprox.address, abi, accounts[0]);


    const respons = await proxied.hello();
    const response = await proxied.getInt();
    console.log("REsponse" + response)

    




   
  });
});
