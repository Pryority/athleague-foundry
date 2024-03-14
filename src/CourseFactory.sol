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
    function createCourse(address checkpoint0, uint8 gameMode)
        external
        override
        noDelegateCall
        returns (address course)
    {
        /*(address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);*/
        require(checkpoint0 != address(0));
        require(getCourse[checkpoint0][gameMode] == address(0));
        course = deploy(address(this), checkpoint0, gameMode);
        getCourse[checkpoint0][gameMode] = course;
        emit CourseCreated(course, checkpoint0, gameMode);
    }
}
