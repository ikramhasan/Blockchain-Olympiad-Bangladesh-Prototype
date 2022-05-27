// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract UsersContract {
    uint256 public userCount;

    struct User {
        uint256 id;
        string name;
        string nid;
        string imageUrl;
        string birthDate;
    }

    mapping(uint256 => User) public users;

    event UserCreated(
        uint256 id,
        string name,
        string nid,
        string imageUrl,
        string birthDate
    );

    function createUser(
        string memory _name,
        string memory _nid,
        string memory _imageUrl,
        string memory _birthDate
    ) public {
        users[userCount] = User(userCount, _name, _nid, _imageUrl, _birthDate);
        emit UserCreated(userCount, _name, _nid, _imageUrl, _birthDate);
        userCount++;
    }

    event UserUpdated(
        uint256 id,
        string name,
        string nid,
        string imageUrl,
        string birthDate
    );

    function updateUser(
        string memory _name,
        string memory _nid,
        string memory _imageUrl,
        string memory _birthDate
    ) public returns (bool success) {
        for (uint256 i = 0; i < userCount; i++) {
            if (compareStrings(users[i].nid, _nid)) {
                users[i].name = _name;
                users[i].nid = _nid;
                users[i].imageUrl = _imageUrl;
                users[i].birthDate = _birthDate;
                emit UserUpdated(userCount, _name, _nid, _imageUrl, _birthDate);
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
