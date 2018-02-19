pragma solidity ^0.4.18;

import './NumStorageDelegate.sol';

contract NumTrackerDelegate1 {

  NumStorageDelegate public _storage;

  function setNum(uint num) public {
    _storage.setNum(num);
  }

  function num() public view returns (uint) {
    return _storage.num();
  }
}
