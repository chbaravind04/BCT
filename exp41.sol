#write a smart contract that allows users to give their name and store it in blockchain
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract NameRegistry {
    mapping(address => string) public names;

    event NameRegistered(address indexed user, string name);

    function registerName(string memory _name) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        names[msg.sender] = _name;
        emit NameRegistered(msg.sender, _name);
    }

    function getName(address _user) public view returns (string memory) {
        return names[_user];
    }
}
