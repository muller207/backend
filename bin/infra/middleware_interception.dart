import 'package:shelf/shelf.dart';

class MInterception {
  static Middleware get contentTypeJson => createMiddleware(
        responseHandler: (Response res) =>
            res.change(headers: {'content-type': 'application/json'}),
      );

  static Middleware get cors {
    final headersAllowed = {'Access-Control-Allow-Origin': '*'};

    Response? handlerOptions(Request req) {
      if (req.method == 'OPTIONS') {
        return Response(200, headers: headersAllowed);
      } else {
        return null;
      }
    }

    Response addCorsHeader(Response res) => res.change(headers: headersAllowed);

    return createMiddleware(
      requestHandler: handlerOptions,
      responseHandler: addCorsHeader,
    );
  }
}
