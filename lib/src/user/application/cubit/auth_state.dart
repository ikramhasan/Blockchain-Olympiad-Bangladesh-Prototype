part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthLoaded extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class UserLoaded extends AuthState {
  final List<User> users;

  UserLoaded(this.users);
}

class UserCreated extends AuthState {}
class UserUpdated extends AuthState {}
