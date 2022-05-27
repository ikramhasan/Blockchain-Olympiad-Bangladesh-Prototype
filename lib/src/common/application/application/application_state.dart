part of 'application_cubit.dart';

@immutable
abstract class ApplicationState {}

class ApplicationLoading extends ApplicationState {}
class ApplicationCreated extends ApplicationState {}

class ApplicationLoaded extends ApplicationState {
  final List<Application> applications;

  ApplicationLoaded(this.applications);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationLoaded &&
        listEquals(other.applications, applications);
  }

  @override
  int get hashCode => applications.hashCode;
}

class ApplicationError extends ApplicationState {
  final String message;

  ApplicationError(this.message);
}
