//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract SendMoney {
    uint public receivedBalance;

    mapping(address => uint) public balances;

    function SendMoneyToContract() public payable {
        receivedBalance += msg.value;
        balances[msg.sender] += msg.value;
    }

    function retrieve(address account) public view returns (uint) {
        return balances[account];
    }

    // Transfer funds back to account

    // The issue is the sendEther function is transfering money but the amount does not get added in metamask account
    // instead more money gets deducted as gas fees to perform transaction as if the user account is performing
    // transaction and not the contract. Please have a look a it.

    // Also how can I import onlyAdmin from RoleControl.sol to implement in sendEther function.

    function sendEther(address payable recipient) external {
        uint bal = retrieve(recipient);
        require(bal > 0, "No stake");
        if (receivedBalance >= bal) {
            recipient.transfer(bal);
            receivedBalance -= bal;
            balances[recipient] = 0;
        }
    }
}
