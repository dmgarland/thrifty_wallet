pragma solidity ^0.4.24;

import "../Thrifty.sol";

contract OwnedWalletProxy {
  Thrifty public wallet;
  bytes private data;

  constructor() public payable {
    wallet = new Thrifty();
  }

  function() public payable {
    if(msg.data.length > 0) {
      data = msg.data;
    }
  }

  function execute() public payable returns (bool) {
    return address(wallet).call(data);
  }

  function fundWallet(uint amount) public {
    address(wallet).transfer(amount);
  }

  function walletBalance() view public returns (uint) {
    return address(wallet).balance;
  }
}
