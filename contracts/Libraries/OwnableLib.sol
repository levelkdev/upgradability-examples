pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/Storage/BaseStorage.sol";

library OwnableLib {

  function getOwner(BaseStorage self) public view returns (address) {
    return self.getAddress("owner");
  }

  function setOwner(BaseStorage self, address owner) public {
    self.setAddress("owner", owner);
  }

}