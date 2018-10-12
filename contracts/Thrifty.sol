pragma solidity ^0.4.24;

contract Thrifty {
  address private owner;
  uint public dailyLimit;

  event LogInt(uint n);
  event LogAddress(address a);
  
  constructor() public {
    owner = msg.sender;
  }

  function setDailyLimit(uint newLimit) public onlyOwner {
    dailyLimit = newLimit;
  }

  function withdraw(uint amount) public {
    require(amount <= dailyLimit);
    owner.transfer(amount);
  }

  function() external payable {}

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
}
