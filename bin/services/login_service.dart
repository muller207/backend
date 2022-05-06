import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../to/auth_to.dart';
import 'user_service.dart';

class LoginService {
  final UserService _userService;
  LoginService(this._userService);

  //check if user exists and password is correct
  Future<int> authenticate(AuthTO to) async {
    try {
      var _user = await _userService.findOneByEmail(to.email);
      if (_user == null) return -1;
      return Password.verify(to.password, _user.password!) ? _user.id! : -1;
    } catch (e) {
      log('[ERROR] -> in Authenticate method by email ${to.email}');
    }
    return -1;
  }
}
