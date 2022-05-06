import '../models/news_model.dart';
import 'generic_service.dart';
import '../utils/list_extension.dart';

class NewsService implements GenericService<NewsModel> {
  final List<NewsModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<NewsModel> findOne(int id) async {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    NewsModel? model = _fakeDB.firstWhereOrNull((e) => e.id == value.id);
    if (model == null) {
      _fakeDB.add(value);
    } else {
      var _index = _fakeDB.indexOf(model);
      _fakeDB[_index] = value;
    }
    return true;
  }
}
