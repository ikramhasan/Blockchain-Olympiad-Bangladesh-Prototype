import 'dart:convert';

class Certificate {
  final String nid;
  final String examType;
  final int bangla;
  final int english;
  final int math;
  final int science;
  final int religion;
  
  Certificate({
    required this.nid,
    required this.examType,
    required this.bangla,
    required this.english,
    required this.math,
    required this.science,
    required this.religion,
  });

  Certificate copyWith({
    String? nid,
    String? examType,
    int? bangla,
    int? english,
    int? math,
    int? science,
    int? religion,
  }) {
    return Certificate(
      nid: nid ?? this.nid,
      examType: examType ?? this.examType,
      bangla: bangla ?? this.bangla,
      english: english ?? this.english,
      math: math ?? this.math,
      science: science ?? this.science,
      religion: religion ?? this.religion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nid': nid,
      'examType': examType,
      'bangla': bangla,
      'english': english,
      'math': math,
      'science': science,
      'religion': religion,
    };
  }

  factory Certificate.fromMap(Map<String, dynamic> map) {
    return Certificate(
      nid: map['nid'] ?? '',
      examType: map['examType'] ?? '',
      bangla: map['bangla']?.toInt() ?? 0,
      english: map['english']?.toInt() ?? 0,
      math: map['math']?.toInt() ?? 0,
      science: map['science']?.toInt() ?? 0,
      religion: map['religion']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Certificate.fromJson(String source) => Certificate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Certificate(nid: $nid, examType: $examType, bangla: $bangla, english: $english, math: $math, science: $science, religion: $religion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Certificate &&
      other.nid == nid &&
      other.examType == examType &&
      other.bangla == bangla &&
      other.english == english &&
      other.math == math &&
      other.science == science &&
      other.religion == religion;
  }

  @override
  int get hashCode {
    return nid.hashCode ^
      examType.hashCode ^
      bangla.hashCode ^
      english.hashCode ^
      math.hashCode ^
      science.hashCode ^
      religion.hashCode;
  }
}
