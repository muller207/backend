import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  //CustomEnv.fromFile('.env-dev');

  final conn = await MySqlConnection.connect(ConnectionSettings(
    host: 'localhost', // await CustomEnv.get<String>(key: 'db_host'),
    port: await CustomEnv.get<int>(key: 'db_port'),
    user: 'dart_user', //await CustomEnv.get<String>(key: 'db_user'),
    password: 'dart_pass', //await CustomEnv.get<String>(key: 'db_pass'),
    db: await CustomEnv.get<String>(key: 'db_schema'),
  ));

  var result = await conn.query('SELECT * FROM users');
  print(result);

  final di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(di.get<LoginApi>().getHandler())
      .add(di.get<BlogApi>().getHandler(isSecure: true))
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
