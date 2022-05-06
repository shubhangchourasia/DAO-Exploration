//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract RoleControl is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN");

    constructor(address root) {
        _setupRole(DEFAULT_ADMIN_ROLE, root);
        _setRoleAdmin(ADMIN_ROLE, DEFAULT_ADMIN_ROLE);
    }

    // Create a bool check to see if a account address has the role admin
    function isAdmin(address account) public view virtual returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, account);
    }

    // Create a modifier that can be used in other contract to make a pre-check
    // That makes sure that the sender of the transaction (msg.sender)  is a admin
    modifier onlyAdmin() {
        require(isAdmin(msg.sender), "Restricted to admins.");
        _;
    }

    // Add a user address as an admin
    function addAdmin(address account) public virtual onlyAdmin {
        grantRole(DEFAULT_ADMIN_ROLE, account);
    }

    // Remove a user address as an admin
    function removeAdmin(address account) public virtual onlyAdmin {
        revokeRole(DEFAULT_ADMIN_ROLE, account);
    }
}
