// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ToolRepToken is ERC20, ERC20Burnable, Pausable, Ownable {
    address toolNFTToken;
    constructor() ERC20("DropRepToken", "DRP") {}

    function pause() public onlyOwner {
        _pause();
    }

    function setToolSOL(address _addr) public onlyOwner {
        toolNFTToken = _addr;
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        _approve(to, toolNFTToken, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}