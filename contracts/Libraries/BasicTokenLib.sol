pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "levelk-upgradability-contracts/contracts/StorageConsumer/StorageConsumerLib.sol";

library BasicTokenLib {
  using SafeMath for uint256;

  function getBalance(StorageConsumerLib.Storage storage self, address balanceHolder) public view returns (uint256) {
    return self.store.getUint(keccak256("balances", balanceHolder));
  }

  function totalSupply(StorageConsumerLib.Storage storage self) public view returns (uint256) {
    return self.store.getUint("totalSupply");
  }

  function addSupply(StorageConsumerLib.Storage storage self, uint256 amount) public {
    self.store.setUint("totalSupply", totalSupply(self).add(amount));
  }

  function addBalance(StorageConsumerLib.Storage storage self, address balanceHolder, uint256 amount) public {
    setBalance(self, balanceHolder, getBalance(self, balanceHolder).add(amount));
  }

  function subBalance(StorageConsumerLib.Storage storage self, address balanceHolder, uint256 amount) public {
    setBalance(self, balanceHolder, getBalance(self, balanceHolder).sub(amount));
  }

  function setBalance(StorageConsumerLib.Storage storage self, address balanceHolder, uint256 amount) private {
    self.store.setUint(keccak256("balances", balanceHolder), amount);
  }

}
