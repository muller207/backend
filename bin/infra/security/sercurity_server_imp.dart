import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../utils/custom_env.dart';
import 'security_server.dart';

class SecurityServerImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'userID': userID,
      'roles': ['admin', 'user'],
    });
    String key = await CustomEnv.get<String>(key: 'jwt_key');
    return jwt.sign(SecretKey(key));
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv.get<String>(key: 'jwt_key');
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }
}
