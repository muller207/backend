import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/news_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericService<NewsModel> _service;
  BlogApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    //get the list of all news
    router.get('/blog/news', (Request req) {
      List<NewsModel> news = _service.findAll();
      List<Map> newsMap = news.map((e) => e.toMap()).toList();
      return Response.ok(
        jsonEncode(newsMap),
      );
    });

    //create new news
    router.post('/blog/news', (Request req) async {
      NewsModel model = NewsModel.fromJson(await req.readAsString());
      _service.save(model);
      return Response(201, body: model.toJson());
    });

    //update news
    router.put('/blog/news', (Request req) async {
      //String? id = req.url.queryParameters['id'];
      //if (id == null) return Response.badRequest(body: 'id is expected');
      NewsModel model = NewsModel.fromJson(await req.readAsString());
      _service.save(model);
      return Response.ok(model.toJson());
    });

    //delete news by id
    router.delete('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest(body: 'id is expected');
      _service.delete(int.parse(id));
      return Response.ok('news removed');
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
