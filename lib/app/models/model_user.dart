import 'dart:convert';

class ModelUser {
  final String user;
  final String password;
  final String name;
  final String profile;

  ModelUser({
    required this.user,
    required this.password,
    required this.name,
    required this.profile,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'password': password,
      'name': name,
      'profile': profile,
    };
  }

  factory ModelUser.fromMap(Map<String, dynamic> map) {
    return ModelUser(
      user: map['user'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      profile: map['profile'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelUser.fromJson(String source) =>
      ModelUser.fromMap(json.decode(source));
}
