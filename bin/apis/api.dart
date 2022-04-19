import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_server.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecure = false,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecure = false,
  }) {
    middlewares ??= [];

    if (isSecure) {
      var _securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        _securityService.authorization,
        _securityService.verifyJwt,
      ]);
    }

    var pipe = Pipeline();
    middlewares.forEach((e) => pipe = pipe.addMiddleware(e));
    return pipe.addHandler(router);
  }
}
