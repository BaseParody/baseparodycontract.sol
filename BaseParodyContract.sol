// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * This contract Developed by "PANTHER". 'blockchaindevpanther@gmail.com'
 *
 *          /\_/\  
 *         ( o.o )
 *          > ^ <
 */
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact : Support@baseparody.xyz

contract BaseParody is ERC20, ERC20Burnable, ERC20Snapshot, Ownable {
    constructor() ERC20("BaseParody", "PBASE") {
        _mint(msg.sender, 1000000000 * 10 ** decimals());
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    function SayHello() public pure returns (string memory) {
        return "Hey Legend, Have a Good Day";
    }

    function deposit() public payable {
        _mint(msg.sender, msg.value);
    }

    function withdraw() public onlyOwner {
        require(msg.sender == owner(), "Only the contract owner can withdraw funds");
        uint256 balance = address(this).balance;
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "Failed to withdraw funds");
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}
