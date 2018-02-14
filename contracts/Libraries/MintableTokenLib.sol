pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/StorageConsumer/StorageConsumerLib.sol";

library MintableTokenLib {

  function getMintingFinished(StorageConsumerLib.Storage storage self) public view returns (bool) {
    return self.store.getBool("mintingFinished");
  }

  function setMintingFinished(StorageConsumerLib.Storage storage self, bool mintingFinished) public {
    return self.store.setBool("mintingFinished", mintingFinished);
  }

}