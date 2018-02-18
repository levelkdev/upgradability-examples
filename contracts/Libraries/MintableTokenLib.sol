pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/Storage/BaseStorage.sol";

library MintableTokenLib {

  function getMintingFinished(BaseStorage self) public view returns (bool) {
    return self.getBool("mintingFinished");
  }

  function setMintingFinished(BaseStorage self, bool mintingFinished) public {
    return self.setBool("mintingFinished", mintingFinished);
  }

}