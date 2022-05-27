import 'package:bloc/bloc.dart';
import 'package:nfc/src/common/domain/certificate.dart';
import 'package:flutter/foundation.dart';
import 'package:nfc/src/common/domain/i_auth_repository.dart';

part 'certificate_state.dart';

class CertificateCubit extends Cubit<CertificateState> {
  CertificateCubit(this._authRepository) : super(CertificateLoading());

  final IAuthRepository _authRepository;

  Future<void> getCertificates() async {
    _getCertificates();
  }

  Future<void> createCertificate({
    required String nid,
    required String examType,
    required int bangla,
    required int english,
    required int math,
    required int science,
    required int religion,
  }) async {
    emit(CertificateLoading());

    final failureOfCertificateCreated = await _authRepository.createCertificate(
      nid: nid,
      examType: examType,
      bangla: bangla,
      english: english,
      math: math,
      science: science,
      religion: religion,
    );

    emit(
      failureOfCertificateCreated.fold(
        (l) => CertificateError(l.message),
        (r) => CertificateCreated(),
      ),
    );

    _getCertificates();
  }

  Future<void> updateCertificate({
    required String nid,
    required String examType,
    required int bangla,
    required int english,
    required int math,
    required int science,
    required int religion,
  }) async {
    emit(CertificateLoading());

    final failureOfCertificateCreated = await _authRepository.updateCertificate(
      nid: nid,
      examType: examType,
      bangla: bangla,
      english: english,
      math: math,
      science: science,
      religion: religion,
    );

    emit(
      failureOfCertificateCreated.fold(
        (l) => CertificateError(l.message),
        (r) => CertificateCreated(),
      ),
    );

    _getCertificates();
  }

  _getCertificates() async {
    emit(CertificateLoading());

    final certificates = await _authRepository.fetchCertificates();

    emit(CertificateLoaded(certificates));
  }
}
