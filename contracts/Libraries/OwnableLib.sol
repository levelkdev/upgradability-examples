pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/StorageConsumer/StorageConsumerLib.sol";

library OwnableLib {

  function getOwner(StorageConsumerLib.Storage storage self) public view returns (address) {
    return self.store.getAddress("owner");
  }

  function setOwner(StorageConsumerLib.Storage storage self, address owner) public {
    self.store.setAddress("owner", owner);
  }

}