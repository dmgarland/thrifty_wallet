pragma solidity ^0.4.24;

import "../../contracts/Thrifty.sol";
import "./ThrowProxy.sol";

contract Hacker {

  constructor() public payable {}

  function setDailyLimitOn(Thrifty wallet) public returns (bool) {
    ThrowProxy t = new ThrowProxy(address(wallet));
    Thrifty(address(t)).setDailyLimit(1000 ether);
    return t.execute.gas(200000 wei)();
  }
  
}
