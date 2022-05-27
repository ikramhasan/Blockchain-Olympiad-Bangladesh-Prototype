import 'dart:convert';

class User {
  final String name;
  final String nid;
  final String imageUrl;
  final String birthDate;

  User({
    required this.name,
    required this.nid,
    required this.imageUrl,
    required this.birthDate,
  });

  factory User.empty() => User(name: '', nid: '', imageUrl: '', birthDate: '');

  User copyWith({
    String? name,
    String? nid,
    String? imageUrl,
    String? birthDate,
  }) {
    return User(
      name: name ?? this.name,
      nid: nid ?? this.nid,
      imageUrl: imageUrl ?? this.imageUrl,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nid': nid,
      'imageUrl': imageUrl,
      'birthDate': birthDate,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      nid: map['nid'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      birthDate: map['birthDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, nid: $nid, imageUrl: $imageUrl, birthDate: $birthDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.name == name &&
        other.nid == nid &&
        other.imageUrl == imageUrl &&
        other.birthDate == birthDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        nid.hashCode ^
        imageUrl.hashCode ^
        birthDate.hashCode;
  }
}
