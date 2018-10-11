pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Thrifty.sol";
import "./helpers/Hacker.sol";

contract TestThrifty {
   uint public initialBalance = 10 ether;

   Thrifty wallet;

   function beforeAll() public {
     wallet = new Thrifty();
   }

   function testEmptyWalletHasZeroBalance() public {
     Assert.equal(address(wallet).balance, 0, "A new, empty wallet should have zero balance");
   }

   function testEmptyWalletHasZeroDailyLimit() public {
     Assert.equal(wallet.dailyLimit(), 0, "A new wallet will not allow withdrawl until the owner sets a daily limit");
   }

   function testOwnerCanSetDailyLimit() public {
     wallet.setDailyLimit(10 ether);
     
     Assert.equal(wallet.dailyLimit(), 10 ether, "The setter should update the daily limit to 10 ether");

     Hacker h = (new Hacker).value(1 ether)();
     Assert.isFalse(h.setDailyLimitOn(wallet), "Expected hacker to get an exception because they are not the owner");

     Assert.equal(wallet.dailyLimit(), 10 ether, "The limit should stil be 10 because only the owner can update");
   }

   function testFundingWallet() public {
     DeployedAddresses.Thrifty().transfer(200 wei);
     Assert.equal(DeployedAddresses.Thrifty().balance, 200 wei, "A new, empty wallet should have zero balance");
   }

  

   // A payable fallback function lets us test transfer calls
   function() external payable {
     
   }
}
