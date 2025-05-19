import 'dart:convert';

class LoginDto {
  final String user;
  final String password;

  LoginDto({required this.user, required this.password});

  Map<String, dynamic> toMap() {
    return {'user': user, 'password': password};
  }

  factory LoginDto.fromMap(Map<String, dynamic> map) {
    return LoginDto(user: map['user'] ?? '', password: map['password'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory LoginDto.fromJson(String source) =>
      LoginDto.fromMap(json.decode(source));
}
