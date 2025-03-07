// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

struct PairNumber {
    uint256 first;
    uint256 second;
}

contract KeepNumber {
    PairNumber[] myArr;
    mapping (address => uint256) locations;
    constructor() {
        
    }

    function keepit(uint256 _num1, uint256 _num2) public {
        require(locations[msg.sender] == 0);
        locations[msg.sender] = myArr.length;
        myArr.push(PairNumber({first:_num1, second:_num2}));
    }

    function getit() public view returns (PairNumber memory) {
        uint256 ind = locations[msg.sender];
        require(ind < myArr.length);
        return myArr[ind];
    }
}