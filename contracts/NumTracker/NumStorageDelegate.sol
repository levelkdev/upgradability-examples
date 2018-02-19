pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/Storage/BaseStorage.sol";

contract NumStorageDelegate is BaseStorage {

  function setNum(uint num) public {
    setUint(keccak256("num"), num);
  }

  function num() public view returns (uint) {
    return getUint(keccak256("num"));
  }
}
