import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_server.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    final _di = DependencyInjector();
    var _securityService = _di.get<SecurityService>();

    middlewares ??= [];
    var pipe = Pipeline();
    middlewares.forEach((e) => pipe = pipe.addMiddleware(e));
    return pipe.addHandler(router);
  }
}
