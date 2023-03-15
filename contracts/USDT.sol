// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestUSDT is ERC20 {
    
    uint8 private constant DECIMALS = 6;

    constructor() ERC20("Test USDT", "TUSDT") {
    }

    function decimals() public view virtual override returns (uint8) {
        return DECIMALS;
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}