import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';
import 'api.dart';

class UserApi extends Api {
  final UserService _service;
  UserApi(this._service);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecure = false,
  }) {
    Router router = Router();

    //create new user
    router.post('/user', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400, body: '{"error": "bad format"}');
      UserModel _user = UserModel.fromRequest(jsonDecode(body));
      var result = await _service.save(_user);
      _user.password = null;
      return result
          ? Response(201, body: jsonEncode(_user.toMap()))
          : Response(500);
    });

    return createHandler(
      router: router,
      isSecure: isSecure,
      middlewares: middlewares,
    );
  }
}
