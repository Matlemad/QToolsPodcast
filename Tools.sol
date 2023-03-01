// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./ToolRepToken.sol";

contract Tools is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    ToolRepToken public repTokenAddress;

    mapping (uint => uint) public idToScore;

    modifier hasRepToken {
        require(repTokenAddress.balanceOf(msg.sender) >= 1*10**17, "you need 0.1 Reputation Token at least");
        _;
    }

    constructor(address _repTok) ERC721("Tools", "TOOL") {
        repTokenAddress = ToolRepToken(address(_repTok)); 
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        idToScore[tokenId] = 0;
    }

    function upvote (uint _tokenId) external hasRepToken {
        idToScore[_tokenId] += 1;
        repTokenAddress.burnFrom(msg.sender, 1*10**17);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
