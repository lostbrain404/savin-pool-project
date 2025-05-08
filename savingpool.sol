// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract  SavingPool{

    address public  owner ;
    uint public unlockTime;
    bool public isClosed = false;

    mapping(address=>uint)public balances;
    mapping(address=>uint)public depositTimes;

    constructor (uint durationInSecond){
        owner = msg.sender;
        unlockTime = block.timestamp+durationInSecond;
    }

    modifier onlyWhenOpen(){
        require(!isClosed,"contract is closed");_;
    }

    function DepositeEth()external payable onlyWhenOpen{
        require(msg.value>0,"Invalid amount");
        balances[msg.sender]+=msg.value;
        depositTimes[msg.sender] = block.timestamp;
    }

    function WithdrawEth()external onlyWhenOpen{
        uint amount =  balances[msg.sender] ;
        require(block.timestamp>unlockTime,"Saving period not ended yet");
        require(balances[msg.sender]>=amount,"No funds to withdraw.");
        amount = 0;
        payable(owner).transfer(address(this).balance);
    }

    function getBalances()external view returns(uint){
        return balances[msg.sender];
    }

    function getDepositTime()external view returns(uint){
        return depositTimes[msg.sender];
    }

    function ClostPool()external{
        require(msg.sender==owner,"Only the Onwer!");
        require(block.timestamp>unlockTime,"Saving period is not ended yet");
        isClosed = true ;
    }

}
