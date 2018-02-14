pragma solidity ^0.4.18;

contract DetailedToken {
  string public name;
  string public symbol;
  uint8 public decimals;

  function DetailedToken(string _name, string _symbol, uint8 _decimals) public {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
  }
}