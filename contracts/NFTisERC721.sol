// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTisERC721 is ERC721, Ownable {

    address public usdtAddress;

    uint256 public constant NFT_PRICE = 100 * 10**6; // Prix en USDT
    uint256 public totalSupply = 0;

    constructor(address _usdtAddress) ERC721("NekrNFT", "NNFT") {
        usdtAddress = _usdtAddress;
    }

    function mint(address to) external {
        IERC20 usdt = IERC20(usdtAddress);
        require(usdt.balanceOf(msg.sender) >= NFT_PRICE, "Insufficient USDT balance");
        require(usdt.allowance(msg.sender, address(this)) >= NFT_PRICE, "USDT allowance too low");

        usdt.transferFrom(msg.sender, address(this), NFT_PRICE);
        
        _mint(to, totalSupply);
        totalSupply = totalSupply + 1;
    }

    function withdraw(address _to) external onlyOwner {
        IERC20 usdt = IERC20(usdtAddress);
        uint256 balance = usdt.balanceOf(address(this));
        usdt.transfer(_to, balance);
    }

}