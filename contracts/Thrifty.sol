pragma solidity ^0.4.24;

contract Thrifty {
  address private owner;
  uint public dailyLimit;
  
  constructor() public {
    owner = msg.sender;
  }

  function setDailyLimit(uint newLimit) public onlyOwner {
    dailyLimit = newLimit;
  }

  function() external payable {}

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
}
