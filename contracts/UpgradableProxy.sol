//SPDX-License-Identifier: centric lol
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract UpgradableProxy {
    uint256 testInt;
    
    
    
    address upgradableLogic;
    bool logicSet;


    //constructor (string memory s) {
     //   version = s;
    //}

    function setLogicAddress(address _logic) public  {
        require(upgradableLogic != _logic, "Cannot upgrade to current version");
        upgradableLogic = _logic;
        logicSet = true;
    }

    function getAddress() public view returns(address) {
        return upgradableLogic;
    }

    function _delegate() internal {
        if (!logicSet) {
            return;
        }

        assembly {
            let ptr := mload(0x40)
            
            calldatacopy(ptr, 0, calldatasize())

            let result := delegatecall(gas(), sload(upgradableLogic.slot), ptr, calldatasize(), 0, 0)

            let size := returndatasize()
            returndatacopy(ptr, 0, size)


            switch result
            case 0 {
                revert(ptr, size)

            } default {
                return(ptr, size)
            }
        }


    }
    
    fallback () external payable {
        _delegate();
    }



    
}
