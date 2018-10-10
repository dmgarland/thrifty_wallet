pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Thrifty.sol";

contract TestThrifty {
   uint public initialBalance = 1 ether;

   Thrifty wallet;

   function beforeAll() public {
     wallet = new Thrifty(); 
   }

   function testEmptyWalletHasZeroBalance() public {
     Assert.equal(address(wallet).balance, 0, "A new, empty wallet should have zro balance");
   }
}
