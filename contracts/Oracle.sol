// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Oracle {
    struct Data {
        uint256 date;
        uint256 payload;
    }

    address public admin;
    mapping(address => bool) public reporters;
    mapping(bytes32 => Data) public data;

    constructor(address _admin) {
        admin = _admin;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only Admin");
        _;
    }
    modifier onlyReporter() {
        require(reporters[msg.sender] == true, "Only Reporter");
        _;
    }

    function updateReporter(address reporter, bool isReporter)
        external
        onlyAdmin
    {
        reporters[reporter] = isReporter;
    }

    function updateData(bytes32 key, uint256 payload) external onlyReporter {
        data[key] = Data(block.timestamp, payload);
    }

    function getData(bytes32 key)
        external
        view
        returns (
            bool result,
            uint256 date,
            uint256 payload
        )
    {
        if (data[key].date == 0) {
            return (false, 0, 0);
        }
        return (true, data[key].date, data[key].payload);
    }
}
