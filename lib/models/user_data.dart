// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserData {
  final String id;
  final String name;
  final String email;
  final String studentNumber;
  final String profileImageUrl;
  final DateTime? lastSignInAt;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.studentNumber,
    required this.profileImageUrl,
    this.lastSignInAt,
  });

  UserData copyWith({
    String? id,
    String? name,
    String? email,
    String? studentNumber,
    String? profileImageUrl,
    DateTime? lastSignInAt,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      studentNumber: studentNumber ?? this.studentNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'studentNumber': studentNumber,
      'profileImageUrl': profileImageUrl,
      'lastSignInAt': lastSignInAt?.millisecondsSinceEpoch,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      studentNumber: map['student_number'],
      profileImageUrl: map['profile_image'],
      lastSignInAt: map['last_sign_in_at'] != null //
          ? DateTime.parse(map['last_sign_in_at']).toLocal()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(id: $id, name: $name, email: $email, studentNumber: $studentNumber, profileImageUrl: $profileImageUrl, lastSignInAt: $lastSignInAt)';
  }
}
