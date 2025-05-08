💰 SavingPool Smart Contract

A simple Ethereum smart contract for time-locked ETH savings.
📦 Features

    Deposit ETH: Users can deposit ETH into the pool anytime before it closes.

    Locking Period: All ETH is locked until a set unlockTime.

    Withdraw ETH: Users can withdraw their own funds after the lock period ends.

    Close the Pool: Only the contract owner can close the pool after the lock period.

    Safe Closure: Uses a bool flag instead of deprecated selfdestruct.

🔍 Functions

    DepositeEth(): Deposit ETH into the pool.

    WithdrawEth(): Withdraw your ETH after unlockTime.

    getBalances(): Check your balance.

    getDepositTime(): Check when you deposited.

    ClostPool(): Owner can permanently close the contract.
