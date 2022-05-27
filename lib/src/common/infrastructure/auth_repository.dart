import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:nfc/src/common/domain/certificate.dart';
import 'package:nfc/src/common/domain/i_auth_repository.dart';
import 'package:nfc/src/user/domain/user.dart';
import 'package:nfc/src/common/domain/failure.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRepository implements IAuthRepository {
  List<User> users = [];
  List<Certificate> certificates = [];

  final String _rpcUrl = dotenv.env['RPC_URL']!;
  final String _wsUrl = dotenv.env['WEBSOCKET_URL']!;
  final String _privateKey = dotenv.env['PRIVATE_KEY']!;

  late Web3Client _web3client;
  late ContractAbi _usersABICode;
  late ContractAbi _certificatesABICode;
  late EthereumAddress _usersContractAddress;
  late EthereumAddress _CertificatesContractAddress;
  late EthPrivateKey _creds;

  AuthRepository._();

  static final AuthRepository _instance = AuthRepository._();

  static AuthRepository get instance => _instance;

  @override
  Future<Either<Failure, Unit>> createUser({
    required String name,
    required String nid,
    required String birthDate,
    required String imageUrl,
  }) async {
    try {
      await _web3client.sendTransaction(
        _creds,
        Transaction.callContract(
          contract: _usersDeployedContract,
          function: _createUser,
          parameters: [name, nid, imageUrl, birthDate],
        ),
      );

      return right(unit);
    } catch (e) {
      print(e);
      return left(Failure.general());
    }
  }

  @override
  Future<void> init() async {
    _web3client = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );

    await _getAbi();
    await _getCredentials();
    await _getDeployedContract();
  }

  Future<void> _getAbi() async {
    final usersABIFile =
        await rootBundle.loadString('build/contracts/UsersContract.json');

    final usersJsonABI = jsonDecode(usersABIFile);

    _usersABICode = ContractAbi.fromJson(
      jsonEncode(usersJsonABI['abi']),
      'UsersContract',
    );

    final certificatesABIFile = await rootBundle
        .loadString('build/contracts/CertificatesContract.json');
    final certificatesJsonABI = jsonDecode(certificatesABIFile);
    _certificatesABICode = ContractAbi.fromJson(
      jsonEncode(certificatesJsonABI['abi']),
      'CertificatesContract',
    );

    _usersContractAddress =
        EthereumAddress.fromHex(usersJsonABI["networks"]["5777"]["address"]);
    _CertificatesContractAddress = EthereumAddress.fromHex(
        certificatesJsonABI["networks"]["5777"]["address"]);
  }

  Future<void> _getCredentials() async {
    _creds = EthPrivateKey.fromHex(_privateKey);
  }

  late DeployedContract _usersDeployedContract;
  late DeployedContract _certificatesDeployedContract;
  late ContractFunction _createUser;
  late ContractFunction _updateUser;
  late ContractFunction _users;
  late ContractFunction _userCount;
  late ContractFunction _createCertificate;
  late ContractFunction _updateCertificate;
  late ContractFunction _certificates;
  late ContractFunction _certificateCount;

  Future<void> _getDeployedContract() async {
    _usersDeployedContract =
        DeployedContract(_usersABICode, _usersContractAddress);
    _certificatesDeployedContract =
        DeployedContract(_certificatesABICode, _CertificatesContractAddress);

    _createUser = _usersDeployedContract.function('createUser');
    _updateUser = _usersDeployedContract.function('updateUser');
    _users = _usersDeployedContract.function('users');
    _userCount = _usersDeployedContract.function('userCount');

    _createCertificate =
        _certificatesDeployedContract.function('createCertificate');
    _updateCertificate =
        _certificatesDeployedContract.function('updateCertificate');
    _certificates = _certificatesDeployedContract.function('certificates');
    _certificateCount =
        _certificatesDeployedContract.function('certificateCount');
  }

  @override
  Future<List<User>> fetchUsers() async {
    List totalUsersList = await _web3client.call(
      contract: _usersDeployedContract,
      function: _userCount,
      params: [],
    );

    int totalUsersLength = totalUsersList[0].toInt();
    users.clear();

    for (int i = 0; i < totalUsersLength; i++) {
      var temp = await _web3client.call(
        contract: _usersDeployedContract,
        function: _users,
        params: [BigInt.from(i)],
      );

      if (temp[1] != '') {
        users.add(
          User(
            name: temp[1],
            nid: temp[2],
            imageUrl: temp[3],
            birthDate: temp[4],
          ),
        );
      }
    }

    return users;
  }

  @override
  Future<Either<Failure, Unit>> updateUser({
    required String name,
    required String nid,
    required String birthDate,
    required String imageUrl,
  }) async {
    try {
      await _web3client.sendTransaction(
        _creds,
        Transaction.callContract(
          contract: _usersDeployedContract,
          function: _updateUser,
          parameters: [name, nid, imageUrl, birthDate],
        ),
      );

      return right(unit);
    } catch (e) {
      print(e);
      return left(Failure.general());
    }
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
          parameters: [
            nid,
            examType,
            BigInt.from(bangla),
            BigInt.from(english),
            BigInt.from(math),
            BigInt.from(science),
            BigInt.from(religion),
          ],
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
          parameters: [
            nid,
            examType,
            BigInt.from(bangla),
            BigInt.from(english),
            BigInt.from(math),
            BigInt.from(science),
            BigInt.from(religion),
          ],
        ),
      );

      return right(unit);
    } catch (e) {
      print(e);
      return left(Failure.general());
    }
  }
}
