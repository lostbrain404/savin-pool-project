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

    function WithdrawEth() external onlyWhenOpen {
        require(block.timestamp > unlockTime, "Saving period not ended yet");
        uint amount = balances[msg.sender];
        require(amount > 0, "No funds to withdraw.");
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
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
