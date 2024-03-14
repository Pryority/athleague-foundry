// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Course.sol";
import "./CourseDeployer.sol";
import "./NoDelegateCall.sol";
import "./interfaces/ICourseFactory.sol";

contract CourseFactory is ICourseFactory, CourseDeployer, NoDelegateCall {

    /// @inheritdoc ICourseFactory
    address public override owner;
    mapping(address => mapping(uint8 => address)) public override getCourse;

    constructor() {
        owner = msg.sender;
        emit OwnerChanged(address(0), msg.sender);
    }

    /// @inheritdoc ICourseFactory
    function createCourse(address checkpoint, uint8 gameMode)
        external
        override
        noDelegateCall
        returns (address course)
    {
        /*(address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);*/
        /*require(checkpoint != address(0));*/
        require(getCourse[checkpoint][gameMode] == address(0));
        course = deploy(address(this), checkpoint, gameMode);
        getCourse[checkpoint][gameMode] = course;
        emit CourseCreated(course, checkpoint, gameMode);
    }
}
