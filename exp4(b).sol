#write a smart contract that allows users to store a number in blockchain and then retrieve it 
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract NumberStorage {
    mapping(address => uint256) private numbers;

    event NumberStored(address indexed user, uint256 number);
    event NumberRetrieved(address indexed user, uint256 number);

    function storeNumber(uint256 _number) public {
        numbers[msg.sender] = _number;
        emit NumberStored(msg.sender, _number);
    }

    function retrieveNumber() public view returns (uint256) {
        return numbers[msg.sender];
    }
}
