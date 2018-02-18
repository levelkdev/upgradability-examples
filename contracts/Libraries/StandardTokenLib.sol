pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "levelk-upgradability-contracts/contracts/Storage/BaseStorage.sol";

library StandardTokenLib {
  using SafeMath for uint256;

  function getAllowed(
    BaseStorage self,
    address owner,
    address spender
  )
    public view returns (uint256)
  {
    return self.getUint(keccak256("allowed", owner, spender));
  }

  function addAllowed(
    BaseStorage self,
    address owner,
    address spender,
    uint256 amount
  )
    public
  {
    setAllowed(self, owner, spender, getAllowed(self, owner, spender).add(amount));
  }

  function subAllowed(
    BaseStorage self,
    address owner,
    address spender,
    uint256 amount
  )
    public
  {
    setAllowed(self, owner, spender, getAllowed(self, owner, spender).sub(amount));
  }

  function setAllowed(
    BaseStorage self,
    address owner,
    address spender,
    uint256 amount
  )
    public 
  {
    self.setUint(keccak256("allowed", owner, spender), amount);
  }

}
