// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

interface IOracle {
    function getData(bytes32 key)
        external
        view
        returns (
            bool result,
            uint256 date,
            uint256 payload
        );
}
