pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/Proxy/OwnableProxy.sol";
import "levelk-upgradability-contracts/contracts/Storage/BaseStorage.sol";
import "levelk-upgradability-contracts/contracts/StorageConsumer/StorageConsumer.sol";
import "./DetailedToken.sol";

contract MyToken is StorageConsumer, OwnableProxy, DetailedToken {

  function MyToken(BaseStorage storage_, address delegate, string name, string symbol, uint8 decimals)
    public
    StorageConsumer(storage_)
    OwnableProxy(delegate)
    DetailedToken(name, symbol, decimals)
  { }

}
