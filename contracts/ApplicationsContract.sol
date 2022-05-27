// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ApplicationsContract {
    uint256 public applicationCount;

    struct Application {
        uint256 id;
        string applicationType;
        string nid;
        string message;
        string status;
    }

    mapping(uint256 => Application) public applications;

    event ApplicationCreated(
        uint256 id,
        string applicationType,
        string nid,
        string message,
        string status
    );

    function createApplication(
        string memory _applicationType,
        string memory _nid,
        string memory _message,
        string memory _status
    ) public {
        applications[applicationCount] = Application(
            applicationCount,
            _applicationType,
            _nid,
            _message,
            _status
        );

        emit ApplicationCreated(
            applicationCount,
            _applicationType,
            _nid,
            _message,
            _status
        );

        applicationCount++;
    }

    event ApplicationUpdated(
        uint256 id,
        string applicationType,
        string nid,
        string message,
        string status
    );

    function updateApplication(
        string memory _applicationType,
        string memory _nid,
        string memory _message,
        string memory _status
    ) public returns (bool success) {
        for (uint256 i = 0; i < applicationCount; i++) {
            if (
                compareStrings(applications[i].nid, _nid) &&
                compareStrings(applications[i].message, _message)
            ) {
                applications[i].nid = _nid;
                applications[i].applicationType = _applicationType;
                applications[i].message = _message;
                applications[i].status = _status;
                emit ApplicationUpdated(
                    applicationCount,
                    _applicationType,
                    _nid,
                    _message,
                    _status
                );
                return true;
            }
        }
        return false;
    }

    function compareStrings(string memory a, string memory b)
        public
        pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }
}
