import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_server.dart';

class LoginApi {
  final SecurityService _securityService;
  LoginApi(this._securityService);

  Handler get handler {
    Router router = Router();

    router.post('/login', (Request req) async {
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);
      if (result == null) return Response.forbidden('token not valid');
      return Response.ok('logged in');
    });

    return router;
  }
}
