pragma solidity ^0.4.18;

import "../Libraries/BasicTokenLib.sol";
import "../Libraries/MintableTokenLib.sol";
import "./OwnableDelegate.sol";
import "./StandardTokenDelegate.sol";


/**
 * @title Mintable token
 * @dev Simple ERC20 Token example, with mintable token creation
 * @dev Issue: * https://github.com/OpenZeppelin/zeppelin-solidity/issues/120
 * Based on code by TokenMarketNet: https://github.com/TokenMarketNet/ico/blob/master/contracts/MintableToken.sol
 */
contract MintableTokenDelegate is StandardTokenDelegate, OwnableDelegate {
  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  modifier canMint() {
    require(!MintableTokenLib.getMintingFinished(_storage));
    _;
  }

  /**
   * @dev Function to mint tokens
   * @param to The address that will receive the minted tokens.
   * @param amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(address to, uint256 amount) onlyOwner canMint public returns (bool) {
    BasicTokenLib.addSupply(_storage, amount);
    BasicTokenLib.addBalance(_storage, to, amount);
    Mint(to, amount);
    Transfer(address(0), to, amount);
    return true;
  }

  /**
   * @dev Function to stop minting new tokens.
   * @return True if the operation was successful.
   */
  function finishMinting() onlyOwner canMint public returns (bool) {
    MintableTokenLib.setMintingFinished(_storage, true);
    MintFinished();
    return true;
  }
}