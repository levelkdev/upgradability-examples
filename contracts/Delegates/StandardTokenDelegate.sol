pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "./BasicTokenDelegate.sol";
import "../Libraries/BasicTokenLib.sol";
import "../Libraries/StandardTokenLib.sol";

contract StandardTokenDelegate is ERC20, BasicTokenDelegate {
  using SafeMath for uint256;

    /**
   * @dev Transfer tokens from one address to another
   * @param from address The address which you want to send tokens from
   * @param to address The address which you want to transfer to
   * @param value uint256 the amount of tokens to be transferred
   */
  function transferFrom(address from, address to, uint256 value) public returns (bool) {
    require(to != address(0));
    require(value <= BasicTokenLib.getBalance(_storage, from));
    require(value <= StandardTokenLib.getAllowed(_storage, from, msg.sender));

    BasicTokenLib.subBalance(_storage, from, value);
    BasicTokenLib.addBalance(_storage, to, value);
    StandardTokenLib.subAllowed(_storage, from, msg.sender, value);
    Transfer(from, to, value);
    return true;
  }

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   *
   * Beware that changing an allowance with this method brings the risk that someone may use both the old
   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   * @param spender The address which will spend the funds.
   * @param value The amount of tokens to be spent.
   */
  function approve(address spender, uint256 value) public returns (bool) {
    StandardTokenLib.setAllowed(_storage, msg.sender, spender, value);
    Approval(msg.sender, spender, value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param owner address The address which owns the funds.
   * @param spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(address owner, address spender) public view returns (uint256) {
    return StandardTokenLib.getAllowed(_storage, owner, spender);
  }

  /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param spender The address which will spend the funds.
   * @param addedValue The amount of tokens to increase the allowance by.
   */
  function increaseApproval(address spender, uint addedValue) public returns (bool) {
    StandardTokenLib.addAllowed(_storage, msg.sender, spender, addedValue);
    Approval(msg.sender, spender, StandardTokenLib.getAllowed(_storage, msg.sender, spender));
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   *
   * approve should be called when allowed[spender] == 0. To decrement
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param spender The address which will spend the funds.
   * @param subtractedValue The amount of tokens to decrease the allowance by.
   */
  function decreaseApproval(address spender, uint subtractedValue) public returns (bool) {
    uint256 oldValue = StandardTokenLib.getAllowed(_storage, msg.sender, spender);
    if (subtractedValue > oldValue) {
      StandardTokenLib.setAllowed(_storage, msg.sender, spender, 0);
    } else {
      StandardTokenLib.setAllowed(_storage, msg.sender, spender, oldValue.sub(subtractedValue));
    }
    Approval(msg.sender, spender, StandardTokenLib.getAllowed(_storage, msg.sender, spender));
    return true;
  }

}
