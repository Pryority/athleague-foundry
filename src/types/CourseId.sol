// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {CourseKey} from "./CourseKey.sol";

type CourseId is bytes32;

/// @notice Library for computing the ID of a pool
library CourseIdLibrary {
    function toId(CourseKey memory courseKey) internal pure returns (CourseId) {
        return CourseId.wrap(keccak256(abi.encode(courseKey)));
    }
}
