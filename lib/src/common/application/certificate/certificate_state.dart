part of 'certificate_cubit.dart';

@immutable
abstract class CertificateState {}

class CertificateLoading extends CertificateState {}

class CertificateCreated extends CertificateState {}

class CertificateLoaded extends CertificateState {
  final List<Certificate> certificates;

  CertificateLoaded(this.certificates);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CertificateLoaded &&
      listEquals(other.certificates, certificates);
  }

  @override
  int get hashCode => certificates.hashCode;
}

class CertificateError extends CertificateState {
  final String message;

  CertificateError(this.message);


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CertificateError &&
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
