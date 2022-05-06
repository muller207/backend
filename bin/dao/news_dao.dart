import '../infra/database/db_configuration.dart';
import '../models/news_model.dart';
import 'dao.dart';

class NewsDAO implements DAO<NewsModel> {
  final DBConfiguration _dbConfiguration;
  NewsDAO(this._dbConfiguration);

  @override
  Future<bool> create(NewsModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO news (title, description, id_user) VALUES (?, ?, ?)',
      [value.title, value.description, value.userId],
    );
    return result.affectedRows ?? 0 > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result =
        await _dbConfiguration.execQuery('DELETE FROM news WHERE id = ?', [id]);
    return result.affectedRows ?? 0 > 0;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM news');
    return result
        .map((r) => NewsModel.fromMap(r.fields))
        .toList()
        .cast<NewsModel>();
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM news WHERE id = ?', [id]);
    return result.isEmpty ? null : NewsModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(NewsModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE news SET title = ?, description = ? WHERE id = ?',
      [value.title, value.description, value.id],
    );
    return result.affectedRows ?? 0 > 0;
  }
}
