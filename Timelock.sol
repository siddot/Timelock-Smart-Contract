// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.11;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract TimeLockedWallet {

    address public owner;
    uint256 public unlockDate = block.timestamp;
    uint public depositTime;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }


    constructor() {
        owner = msg.sender;
    }


    // keep all the ether sent to this address
    function deposit() public payable onlyOwner{
        depositTime = block.timestamp;
    }

    // callable by owner only, after specified time
    function withdraw() onlyOwner public {
       require(depositTime + 90 days <= block.timestamp, "Can't withdraw before unlock!!!");
       //now send all the balance
       payable(msg.sender).transfer(address(this).balance);
    }

}