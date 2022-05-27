import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nfc/src/common/domain/i_auth_repository.dart';
import 'package:nfc/src/user/domain/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());

  final IAuthRepository _authRepository;

  Future<void> init() async {
    emit(AuthLoading());
    await _authRepository.init();
    emit(AuthLoaded());
  }

  Future<void> getUsers() async {
    _getUsers();
  }

  Future<void> createUser({
    required String name,
    required String nid,
    required String birthDate,
    required String imageUrl,
  }) async {
    emit(AuthLoading());

    final failureOrUserCreated = await _authRepository.createUser(
      name: name,
      nid: nid,
      birthDate: birthDate,
      imageUrl: imageUrl,
    );

    emit(
      failureOrUserCreated.fold(
        (l) => AuthFailure(l.message),
        (r) => UserCreated(),
      ),
    );

    _getUsers();
  }

  Future<void> updateUser({
    required String name,
    required String nid,
    required String birthDate,
    required String imageUrl,
  }) async {
    emit(AuthLoading());

    final failureOrUserCreated = await _authRepository.updateUser(
      name: name,
      nid: nid,
      birthDate: birthDate,
      imageUrl: imageUrl,
    );

    emit(
      failureOrUserCreated.fold(
        (l) => AuthFailure(l.message),
        (r) => UserCreated(),
      ),
    );

    _getUsers();
  }

  _getUsers() async {
    emit(AuthLoading());

    final users = await _authRepository.fetchUsers();

    emit(UserLoaded(users));
  }
}
