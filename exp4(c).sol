#write a smart contract that allows users to vote their favourite colour blue yellow green and red
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract ColorVoting {
    enum Color {Blue, Yellow, Green, Red}

    mapping(Color => uint256) private votes;

    event Voted(address indexed user, Color color);

    function vote(Color _color) public {
        require(_color >= Color.Blue && _color <= Color.Red, "Invalid color");
        votes[_color]++;
        emit Voted(msg.sender, _color);
    }

    function getVoteCount(Color _color) public view returns (uint256) {
        require(_color >= Color.Blue && _color <= Color.Red, "Invalid color");
        return votes[_color];
    }

    function getTotalVotes() public view returns (uint256) {
        uint256 totalVotes = 0;
        for (uint8 i = 0; i < 4; i++) {
            totalVotes += votes[Color(i)];
        }
        return totalVotes;
    }
}
