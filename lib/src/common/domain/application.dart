import 'dart:convert';

class Application {
  final String nid;
  final String message;
  final String status;
  final String applicationType;
  
  Application({
    required this.nid,
    required this.message,
    required this.status,
    required this.applicationType,
  });

  Application copyWith({
    String? nid,
    String? message,
    String? status,
    String? applicationType,
  }) {
    return Application(
      nid: nid ?? this.nid,
      message: message ?? this.message,
      status: status ?? this.status,
      applicationType: applicationType ?? this.applicationType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nid': nid,
      'message': message,
      'status': status,
      'applicationType': applicationType,
    };
  }

  factory Application.fromMap(Map<String, dynamic> map) {
    return Application(
      nid: map['nid'] ?? '',
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      applicationType: map['applicationType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Application.fromJson(String source) => Application.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Application(nid: $nid, message: $message, status: $status, applicationType: $applicationType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Application &&
      other.nid == nid &&
      other.message == message &&
      other.status == status &&
      other.applicationType == applicationType;
  }

  @override
  int get hashCode {
    return nid.hashCode ^
      message.hashCode ^
      status.hashCode ^
      applicationType.hashCode;
  }
}
