import 'dart:convert';

class AuthTO {
  final String email;
  final String password;

  AuthTO(this.email, this.password);

  factory AuthTO.fromRequest(String source) {
    var map = jsonDecode(source);
    return AuthTO(map['email'], map['password']);
  }
}
