import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/sercurity_server_imp.dart';
import 'services/news_service.dart';
import 'utils/custom_env.dart';

void main() async {
  //CustomEnv.fromFile('.env-dev');

  var cascadeHandler = Cascade()
      .add(LoginApi(SecurityServerImp()).handler)
      .add(BlogApi(NewsService()).handler)
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(SecurityServerImp().authorization)
      .addHandler(cascadeHandler);

  await CustomServer().initializate(
    handler: handler,
    address: 'localhost', //await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
