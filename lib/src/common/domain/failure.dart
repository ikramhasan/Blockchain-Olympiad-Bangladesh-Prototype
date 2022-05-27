import 'dart:convert';

class Failure {
  final String message;
  final int code;

  Failure({
    required this.message,
    required this.code,
  });

  factory Failure.none() => Failure(message: '', code: 0);
  factory Failure.general() => Failure(
        message:
            'Something went wrong! Please try again later. Contact support if the problem persists.',
        code: 101,
      );

  Failure copyWith({
    String? message,
    int? code,
  }) {
    return Failure(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'code': code,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      message: map['message'] ?? '',
      code: map['code']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source));

  @override
  String toString() => 'Failure(message: $message, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}
