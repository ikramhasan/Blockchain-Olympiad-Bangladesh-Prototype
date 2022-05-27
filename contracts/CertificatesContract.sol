// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract CertificatesContract {
    uint256 public certificateCount;

    struct Certificate {
        uint256 id;
        string nid;
        string examType;
        uint256 bangla;
        uint256 english;
        uint256 math;
        uint256 science;
        uint256 religion;
    }

    mapping(uint256 => Certificate) public certificates;

    event CertificateCreated(
        uint256 id,
        string nid,
        string examType,
        uint256 bangla,
        uint256 english,
        uint256 math,
        uint256 science,
        uint256 religion
    );

    function createCertificate(
        string memory _nid,
        string memory _examType,
        uint256 _bangla,
        uint256 _english,
        uint256 _math,
        uint256 _science,
        uint256 _religion
    ) public {
        certificates[certificateCount] = Certificate(
            certificateCount,
            _nid,
            _examType,
            _bangla,
            _english,
            _math,
            _science,
            _religion
        );
        emit CertificateCreated(
            certificateCount,
            _nid,
            _examType,
            _bangla,
            _english,
            _math,
            _science,
            _religion
        );
        certificateCount++;
    }

    event CertificateUpdated(
        uint256 id,
        string nid,
        string examType,
        uint256 bangla,
        uint256 english,
        uint256 math,
        uint256 science,
        uint256 religion
    );

    function updateCertificate(
        string memory _nid,
        string memory _examType,
        uint256 _bangla,
        uint256 _english,
        uint256 _math,
        uint256 _science,
        uint256 _religion
    ) public returns (bool success) {
        for (uint256 i = 0; i < certificateCount; i++) {
            if (
                compareStrings(certificates[i].nid, _nid) &&
                compareStrings(certificates[i].examType, _examType)
            ) {
                certificates[i].examType = _examType;
                certificates[i].nid = _nid;
                certificates[i].bangla = _bangla;
                certificates[i].english = _english;
                certificates[i].math = _math;
                certificates[i].science = _science;
                certificates[i].religion = _religion;
                emit CertificateUpdated(
                    certificateCount,
                    _nid,
                    _examType,
                    _bangla,
                    _english,
                    _math,
                    _science,
                    _religion
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
