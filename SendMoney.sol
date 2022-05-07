//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract SendMoney {
    uint256 public receivedBalance;

    mapping(address => uint256) public balances;

    function SendMoneyToContract() public payable {
        receivedBalance += msg.value;
        balances[msg.sender] += msg.value;
    }

    function retrieve(address account) public view returns (uint256) {
        return balances[account];
    }
}
