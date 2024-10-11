// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthData {
  final String tokenType;
  final String token;
  final DateTime expiresAt;

  AuthData({
    required this.tokenType,
    required this.token,
    required this.expiresAt,
  });

  AuthData copyWith({
    String? tokenType,
    String? token,
    DateTime? expiresAt,
  }) {
    return AuthData(
      tokenType: tokenType ?? this.tokenType,
      token: token ?? this.token,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token_type': tokenType,
      'access_token': token,
      'expires_at': expiresAt.millisecondsSinceEpoch,
    };
  }

  // NOTE: AuthData 로 매핑
  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      tokenType: map['token_type'],
      token: map['access_token'],
      expiresAt: DateTime.fromMillisecondsSinceEpoch(map['expires_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthData(tokenType: $tokenType, token: $token, expiresAt: $expiresAt)';
}
