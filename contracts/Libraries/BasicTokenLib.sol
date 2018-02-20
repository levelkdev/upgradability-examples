pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "levelk-upgradability-contracts/contracts/Storage/BaseStorage.sol";

library BasicTokenLib {
  using SafeMath for uint256;

  function getBalance(BaseStorage self, address balanceHolder) public view returns (uint256) {
    return self.getUint(keccak256("balances", balanceHolder));
  }

  function totalSupply(BaseStorage self) public view returns (uint256) {
    return self.getUint("totalSupply");
  }

  function addSupply(BaseStorage self, uint256 amount) public {
    self.setUint("totalSupply", totalSupply(self).add(amount));
  }

  function addBalance(BaseStorage self, address balanceHolder, uint256 amount) public {
    setBalance(self, balanceHolder, getBalance(self, balanceHolder).add(amount));
  }

  function subBalance(BaseStorage self, address balanceHolder, uint256 amount) public {
    setBalance(self, balanceHolder, getBalance(self, balanceHolder).sub(amount));
  }

  function setBalance(BaseStorage self, address balanceHolder, uint256 amount) private {
    self.setUint(keccak256("balances", balanceHolder), amount);
  }

}
