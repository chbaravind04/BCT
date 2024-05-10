// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

library MerkleTree {
    function hashPair(bytes32 _a, bytes32 _b) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_a, _b));
    }

    function getParent(bytes32 _left, bytes32 _right) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_left, _right));
    }

    function getRoot(bytes32[] memory _leaves) internal pure returns (bytes32) {
        uint len = _leaves.length;
        require(len > 0, "MerkleTree: No leaves provided");

        bytes32[] memory nodes = new bytes32[](len * 2 - 1);
        uint cursor = 0;

        for (uint i = 0; i < len; i++) {
            nodes[cursor] = _leaves[i];
            cursor++;
        }

        for (uint j = 0; j < len - 1; j++) {
            for (uint k = 0; k < len - j; k += 2) {
                nodes[cursor] = getParent(nodes[j * 2 + k], nodes[j * 2 + k + 1]);
                cursor++;
            }
        }

        return nodes[nodes.length - 1];
    }

    function verifyProof(bytes32 _root, bytes32 _leaf, bytes32[] memory _proof) internal pure returns (bool) {
        bytes32 computedHash = _leaf;

        for (uint i = 0; i < _proof.length; i++) {
            bytes32 proofElement = _proof[i];

            if (computedHash < proofElement) {
                computedHash = getParent(computedHash, proofElement);
            } else {
                computedHash = getParent(proofElement, computedHash);
            }
        }

        return computedHash == _root;
    }
}
