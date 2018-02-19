pragma solidity ^0.4.18;

import './NumTrackerDelegate1.sol';

contract NumTrackerDelegate2 is NumTrackerDelegate1 {

  function addOne() public {
    _storage.setNum(_storage.num() + 1);
  }
}
