// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CoordinateMath} from "./CoordinateMath.sol";
import {Checkpoint} from "./Checkpoint.sol";

library Course {
    // this is not used but needs to be
    /*using TryBitmap for mapping(int8 => uint256);*/
    using Checkpoint for mapping(bytes32 => Checkpoint.Info);
    using Checkpoint for Checkpoint.Info;
    using Course for State;

    struct Slot0 {
        int32 startLat;
        int32 startLng;
        uint256 completions;
        address leader;
    }

    struct TryInfo {
        // the number of checkpoints completed
        uint8 completedCount;
        // the address of the player trying the course
        address player;
        // time counting seconds elapsed since the course try start
        uint256 elapsedTime;
    }

    struct State {
        Slot0 slot0;
        mapping(int8 index => TryInfo tryInfo) tries;
        mapping(int8 => Checkpoint.Info) checkpoints;
        /*With int8, you have 128 possible values, ranging from -128 to 127, which effectively allows for 128 checkpoints if you only consider positive indices.*/
        /*With uint8, you have 256 possible values, ranging from 0 to 255, which allows for 256 checkpoints.*/
        mapping(int8 => uint256) tryBitmap;
    }

    // Initialize the course state
    function initialize(State storage self, int32 startLat, int32 startLng) internal {
        // Set the initial values for the course slot
        self.slot0 = Slot0({
            startLat: startLat,
            startLng: startLng,
            completions: 0,
            leader: address(0)
        });
    }

    // Add a checkpoint to the course
    /*function addCheckpoint(State storage self, int8 index, int32 lat, int32 lng) internal {
        // Create a new checkpoint with the provided index, latitude, and longitude
        self.checkpoints[index] = Checkpoint.Info({latitude: lat, longitude: lng});
    }*/

    // Mark a checkpoint as completed
    /*function markCheckpointCompleted(State storage self, address player, int8 index) internal {
        // Ensure the checkpoint index is valid
        require(index >= 0 && index < 128, "Invalid checkpoint index");

        // Update the try information for the player
        self.tries[index].completedCount++;
        self.tries[index].player = player;
        // Update the try bitmap to mark the try as completed
        self.tryBitmap[index] |= (1 << uint8(index));
    }*/
    /*function getCheckpoints() public view returns (address[] memory) {
        return checkpoints;
    }*/

    /*
    function markCheckpointCompleted(Info storage info, address player, uint256 index) internal {
        require(index < info.numCheckpoints, "Index out of bounds");
        require(!isCheckpointCompleted(info, player, index), "Checkpoint already completed.");

        info.checkpointsCompleted[player][index] = true;
    }

    function isCheckpointCompleted(Info storage info, address player, uint256 index) internal view returns (bool) {
        require(index < info.numCheckpoints, "Index out of bounds.");

        return info.checkpointsCompleted[player][index];
    }


    modifier isBuilt() {
        require(built, "Course has not yet been built.");
        _;
    }

    function buy(bytes32 commitment) public payable {
        require(msg.value >= 0.001 ether);
        require(now < ticketingCloses);

        commitments[msg.sender] = commitment;
    }

    function createRaceCommitment(address player, uint256 rand) public pure returns (bytes32) {
        return keccak256(abi.encode(player, rand));
    }
    */
    /*function addCheckpoint(int256 lat, int256 long) public onlyOwner {
        checkpoints.push(
            Checkpoint({coord: Coord({lat: lat, long: long}), sequence: checkpoints.length, completed: false})
        );
    }

    function addCheckpoints(int256[] memory latitudes, int256[] memory longitudes) public onlyOwner {
        require(latitudes.length == longitudes.length, "Number of latitudes must match number of longitudes.");

        for (uint256 i = 0; i < latitudes.length; i++) {
            checkpoints.push(
                Checkpoint({
                    coord: Coord({lat: latitudes[i], long: longitudes[i]}),
                    sequence: checkpoints.length,
                    completed: false
                })
            );
        }
    }

    function removeCheckpoint(uint256 index) public onlyOwner {
        require(checkpoints.length > 0, "At least one checkpoint must be added.");
        require(index < checkpoints.length, "Index out of bounds.");
        checkpoints[index] = checkpoints[checkpoints.length - 1];
        checkpoints.pop();
    }

    function build() public onlyOwner {
        require(checkpoints.length > 1, "At least two checkpoints must be added.");
        built = true;
    }

    function getCheckpoints() public view returns (Checkpoint[] memory) {
        return checkpoints;
    }*/

    /*

    function markCheckpointCompleted(uint256 index, address racer) public {
        require(index < checkpoints.length, "Index out of bounds.");
        require(!checkpoints[index].completed, "Checkpoint has already been completed.");
        require(racer != address(0), "Racer address cannot be null.");
        require(startTimes[racer] != 0, "Racer has not started the course yet.");
        require(
            checkpoints[index].sequence == 0 || checkpoints[index - 1].completed,
            "Checkpoints must be completed in order."
        );

        checkpoints[index].completed = true;

        if (index == checkpoints.length - 1) {
            finishCourse(racer);
        }
    }

    function startCourse() public {
        require(startTimes[msg.sender] == 0, "Racer has already started the course.");

        startTimes[msg.sender] = block.timestamp;
    }

    function finishCourse(address racer) public {
        require(checkpoints[checkpoints.length - 1].completed, "Course has not been completed.");
        require(startTimes[racer] != 0, "Racer has not started the course yet.");
        require(finishTimes[racer] == 0, "Racer has already finished the course.");

        finishTimes[racer] = block.timestamp;
    }*/
}
