import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Data {
  final int? id;
  final String title;
  final String deskripsi;
  final DateTime createdAt;
  Data({
    this.id,
    required this.title,
    required this.deskripsi,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'deskripsi': deskripsi,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      deskripsi: map['deskripsi'] as String,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdAt'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);
}
