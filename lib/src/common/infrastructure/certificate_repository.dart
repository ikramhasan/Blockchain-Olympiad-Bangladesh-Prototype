import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nfc/src/common/domain/failure.dart';
import 'package:nfc/src/common/domain/certificate.dart';
import 'package:dartz/dartz.dart';
import 'package:nfc/src/common/domain/i_certificate_repository.dart';
import 'package:web3dart/web3dart.dart';

class CertificateReository implements ICertificateRepository {
  List<Certificate> certificates = [];

  late Web3Client _web3client;
  late ContractAbi _certificatesABICode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _creds;
  late DeployedContract _certificatesDeployedContract;

  late ContractFunction _createCertificate;
  late ContractFunction _updateCertificate;
  late ContractFunction _certificates;
  late ContractFunction _certificateCount;

  Future<void> _getAbi() async {
    final certificatesABIFile = await rootBundle
        .loadString('build/contracts/CertificatesContract.json');
    final certificatesJsonABI = jsonDecode(certificatesABIFile);
    _certificatesABICode = ContractAbi.fromJson(
      jsonEncode(certificatesJsonABI['abi']),
      'CertificatesContract',
    );

    // _contractAddress =
    //     EthereumAddress.fromHex(usersJsonABI["networks"]["5777"]["address"]);
  }

  @override
  Future<Either<Failure, Unit>> createCertificate({
    required String nid,
    required String examType,
    required int bangla,
    required int english,
    required int math,
    required int science,
    required int religion,
  }) async {
    try {
      await _web3client.sendTransaction(
        _creds,
        Transaction.callContract(
          contract: _certificatesDeployedContract,
          function: _createCertificate,
          parameters: [nid, examType, bangla, english, math, science, religion],
        ),
      );

      return right(unit);
    } catch (e) {
      print(e);
      return left(Failure.general());
    }
  }

  @override
  Future<List<Certificate>> fetchCertificates() async {
    List totalCertificatesList = await _web3client.call(
      contract: _certificatesDeployedContract,
      function: _certificateCount,
      params: [],
    );

    int totalCertificatesLength = totalCertificatesList[0].toInt();
    certificates.clear();

    for (int i = 0; i < totalCertificatesLength; i++) {
      var temp = await _web3client.call(
        contract: _certificatesDeployedContract,
        function: _certificates,
        params: [BigInt.from(i)],
      );

      if (temp[1] != '') {
        certificates.add(
          Certificate(
            nid: temp[1],
            examType: temp[2],
            bangla: temp[3].toInt(),
            english: temp[4].toInt(),
            math: temp[5].toInt(),
            science: temp[6].toInt(),
            religion: temp[7].toInt(),
          ),
        );
      }
    }

    return certificates;
  }

  @override
  Future<Either<Failure, Unit>> updateCertificate({
    required String nid,
    required String examType,
    required int bangla,
    required int english,
    required int math,
    required int science,
    required int religion,
  }) async {
    try {
      await _web3client.sendTransaction(
        _creds,
        Transaction.callContract(
          contract: _certificatesDeployedContract,
          function: _updateCertificate,
          parameters: [nid, examType, bangla, english, math, science, religion],
        ),
      );

      return right(unit);
    } catch (e) {
      print(e);
      return left(Failure.general());
    }
  }
}
