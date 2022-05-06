//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintContract is ERC721, Ownable {
    uint256 public mintPrice = 0 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721("Pizza Mint", "PIZZAMINT") {
        maxSupply = 100;
    }

    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function mint(address _targetAddress) external payable onlyOwner {
        require(isMintEnabled, "minting not enable");
        require(mintedWallets[_targetAddress] < 1, "exceeds max per wallet");
        require(msg.value == mintPrice, "wrong value");
        require(maxSupply > totalSupply, "sold out");

        mintedWallets[_targetAddress]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(_targetAddress, tokenId);
    }
}
