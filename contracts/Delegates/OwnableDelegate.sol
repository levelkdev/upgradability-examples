pragma solidity ^0.4.18;

import "levelk-upgradability-contracts/contracts/StorageConsumer/StorageStateful.sol";
import "../Libraries/OwnableLib.sol";

/**
 * @title OwnableDelegate
 * @dev The OwnableDelegate contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract OwnableDelegate is StorageStateful {

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == OwnableLib.getOwner(_storage));
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(OwnableLib.getOwner(_storage), newOwner);
    OwnableLib.setOwner(_storage, newOwner);
  }

}