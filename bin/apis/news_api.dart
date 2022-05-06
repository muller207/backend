import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/news_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class NewsApi extends Api {
  final GenericService<NewsModel> _service;
  NewsApi(this._service);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecure = false,
  }) {
    Router router = Router();

    //get the list of all news
    router.get('/news/all', (Request req) async {
      List<NewsModel> news = await _service.findAll();
      List<Map> newsMap = news.map((e) => e.toMap()).toList();
      return Response.ok(
        jsonEncode(newsMap),
      );
    });

    //get news by id
    router.get('/news', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest(body: 'id is expected');
      NewsModel? news = await _service.findOne(int.parse(id));
      return news == null
          ? Response.badRequest(body: '{"error":"user not found"}')
          : Response.ok(news.toJson());
    });

    //create new news
    router.post('/news', (Request req) async {
      NewsModel model = NewsModel.fromJson(await req.readAsString());
      var result = await _service.save(model);
      return result ? Response(201, body: model.toJson()) : Response(500);
    });

    //update news
    router.put('/news', (Request req) async {
      //String? id = req.url.queryParameters['id'];
      //if (id == null) return Response.badRequest(body: 'id is expected');
      NewsModel model = NewsModel.fromJson(await req.readAsString());
      var result = await _service.save(model);
      return result ? Response.ok(model.toJson()) : Response(500);
    });

    //delete news by id
    router.delete('/news', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response.badRequest(body: 'id is expected');
      var result = await _service.delete(int.parse(id));
      return result ? Response.ok('news removed') : Response(500);
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecure: isSecure,
    );
  }
}
