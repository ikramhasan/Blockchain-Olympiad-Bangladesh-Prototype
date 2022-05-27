import 'package:bloc/bloc.dart';
import 'package:nfc/src/common/domain/application.dart';
import 'package:nfc/src/common/domain/i_auth_repository.dart';
import 'package:flutter/foundation.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit(this._authRepository) : super(ApplicationLoading());

  final IAuthRepository _authRepository;

  Future<void> getApplications() async {
    _getApplications();
  }

  Future<void> createApplications({
    required String nid,
    required String message,
    required String status,
    required String applicationType,
  }) async {
    final failureOrApplicationCreated = await _authRepository.createApplication(
      nid: nid,
      message: message,
      status: status,
      applicationType: applicationType,
    );

    emit(
      failureOrApplicationCreated.fold(
        (l) => ApplicationError(l.message),
        (r) => ApplicationCreated(),
      ),
    );

    _getApplications();
  }

  Future<void> updateApplications({
    required String nid,
    required String message,
    required String status,
    required String applicationType,
  }) async {
    emit(ApplicationLoading());
    final failureOrApplicationUpdated = await _authRepository.updateApplication(
      nid: nid,
      message: message,
      status: status,
      applicationType: applicationType,
    );

    emit(
      failureOrApplicationUpdated.fold(
        (l) => ApplicationError(l.message),
        (r) => ApplicationCreated(),
      ),
    );

    _getApplications();
  }

  _getApplications() async {
    emit(ApplicationLoading());

    final applications = await _authRepository.fetchApplications();

    emit(ApplicationLoaded(applications));
  }
}
