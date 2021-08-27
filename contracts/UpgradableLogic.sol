//SPDX-License-Identifier: centric lol
pragma solidity ^0.8.0;

import "./UpgradableProxy.sol";

contract UpgradableLogic {
    uint256 testInt;
    address upgradableLogic;
    bool logicSet;



    function hello() public {
        testInt = 5;
    }

    function getInt() public view returns(uint256) {
        return testInt;
    }
    



}