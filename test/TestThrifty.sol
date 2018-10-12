pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Thrifty.sol";
import "../contracts/helpers/Hacker.sol";
import "../contracts/helpers/OwnedWalletProxy.sol";

contract TestThrifty {
   uint public initialBalance = 10 ether;

   OwnedWalletProxy owner;

   function beforeAll() public {
     owner = OwnedWalletProxy(DeployedAddresses.OwnedWalletProxy());
   }

   function testEmptyWalletHasZeroBalance() public {
     Assert.equal(address(new Thrifty()).balance, 0, "A new, empty wallet should have zero balance");
   }

   function testEmptyWalletHasZeroDailyLimit() public {
     Assert.equal(new Thrifty().dailyLimit(), 0, "A new wallet will not allow withdrawl until the owner sets a daily limit");
   }

   function testOwnerCanSetDailyLimit() public {
     Thrifty(address(owner)).setDailyLimit(10 ether);
     owner.execute();
     
     Assert.equal(owner.wallet().dailyLimit(), 10 ether, "The setter should update the daily limit to 10 ether");

     Hacker h = Hacker(DeployedAddresses.Hacker());
     Assert.isFalse(h.setDailyLimitOn(owner.wallet()), "Expected hacker to get an exception because they are not the owner");

     Assert.equal(owner.wallet().dailyLimit(), 10 ether, "The limit should stil be 10 because only the owner can update");
   }

   function testFundingWallet() public {
     owner.fundWallet(200 wei);
     
     Assert.equal(address(owner.wallet()).balance, 200 wei, "A new, empty wallet should have zero balance");
   }

   // A payable fallback function lets us test transfer calls
   function() external payable {
     
   }
}
