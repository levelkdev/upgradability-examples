pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/Storage/BaseStorage.sol";
import "../Libraries/OwnableLib.sol";
import "./MyToken.sol";

contract MyOwnableToken is MyToken {

  function MyOwnableToken(
    BaseStorage store,
    address delegate,
    string name,
    string symbol,
    uint8 decimals
  )
    public
    MyToken(store, delegate, name, symbol, decimals)
  {}

  function setOwner() public {
    OwnableLib.setOwner(_storage, owner);
  }

}