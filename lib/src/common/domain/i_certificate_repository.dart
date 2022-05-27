import 'package:dartz/dartz.dart';
import 'package:nfc/src/common/domain/certificate.dart';
import 'package:nfc/src/common/domain/failure.dart';

abstract class ICertificateRepository {
  Future<List<Certificate>> fetchCertificates();

  Future<Either<Failure, Unit>> createCertificate({
    required String nid,
    required String examType,
    required int bangla,
    required int english,
    required int math,
    required int science,
    required int religion,
  });

  Future<Either<Failure, Unit>> updateCertificate({
    required String nid,
    required String examType,
    required int bangla,
    required int english,
    required int math,
    required int science,
    required int religion,
  });
}