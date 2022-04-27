import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'models/user_model.dart';
import 'utils/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialize();

  final conn = await _di<DBConfiguration>().connection;
  var result = await conn.query('SELECT * FROM users');
  for (ResultRow r in result) {
    UserModel user = UserModel.fromMap(r.fields);
    print(user.toString());
  }

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(isSecure: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initializate(
    handler: handler,
    address: 'localhost', //await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
  );
}
