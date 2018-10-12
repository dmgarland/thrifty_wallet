pragma solidity ^0.4.24;

import "../Thrifty.sol";

contract OwnedWalletProxy {
  Thrifty public wallet;
  bytes private data;

  event LogAddress(address a);

  constructor() public payable {
    wallet = new Thrifty();
  }

  function() public {
    data = msg.data;
  }

  function execute() public returns (bool) {
    return address(wallet).call(data);
  }

  function fundWallet(uint amount) public {
    address(wallet).transfer(amount);
  }
}
