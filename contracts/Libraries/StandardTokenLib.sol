pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "levelk-upgradability-contracts/contracts/StorageConsumer/StorageConsumerLib.sol";

library StandardTokenLib {
  using SafeMath for uint256;

  function getAllowed(
    StorageConsumerLib.Storage storage self,
    address owner,
    address spender
  )
    public view returns (uint256)
  {
    return self.store.getUint(keccak256("allowed", owner, spender));
  }

  function addAllowed(
    StorageConsumerLib.Storage storage self,
    address owner,
    address spender,
    uint256 amount
  )
    public
  {
    setAllowed(self, owner, spender, getAllowed(self, owner, spender).add(amount));
  }

  function subAllowed(
    StorageConsumerLib.Storage storage self,
    address owner,
    address spender,
    uint256 amount
  )
    public
  {
    setAllowed(self, owner, spender, getAllowed(self, owner, spender).sub(amount));
  }

  function setAllowed(
    StorageConsumerLib.Storage storage self,
    address owner,
    address spender,
    uint256 amount
  )
    public 
  {
    self.store.setUint(keccak256("allowed", owner, spender), amount);
  }

}
