// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library Checkpoint {
    struct Info {
        // the checkpoint's latitude
        int32 latitude;
        // the checkpoint's longitude
        int32 longitude;
        // List of addresses that have completed the checkpoint
        address[] completedBy;
    }
    // Mapping to check if an address has completed the checkpoint
    /*mapping(address => bool) isCompleted;*/

    struct TryInfo {
        // the number of checkpoints completed
        // the address of the player trying the course
        address player;
        // time counting seconds elapsed since the course try start
        uint256 elapsedTime;
    }

    struct State {
        mapping(address player => mapping(uint256 tryIndex => bool complete)) playerCompletionsByTryIndex;
    }

    /// @notice Returns the Info struct of a checkpoint, given an owner and position boundaries
    function get(mapping(bytes32 => Info) storage self, int32 latitude, int32 longitude)
        internal
        view
        returns (Checkpoint.Info storage checkpoint)
    {
        checkpoint = self[keccak256(abi.encodePacked(latitude, longitude))];
    }
}
