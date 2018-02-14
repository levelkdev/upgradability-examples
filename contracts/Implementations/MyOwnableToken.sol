pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/Storage/PublicStorage.sol";
import "../Libraries/OwnableLib.sol";
import "./MyToken.sol";

contract MyOwnableToken is MyToken {

  function MyOwnableToken(PublicStorage store, address delegate, string name, string symbol, uint8 decimals)
    public
    MyToken(store, delegate, name, symbol, decimals)
  {
    OwnableLib.setOwner(_storage, msg.sender);
  }

}
