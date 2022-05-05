import 'package:mysql1/mysql1.dart';

import '../infra/database/db_configuration.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;

  UserDAO(this._dbConfiguration);

  @override
  Future<bool> create(UserModel value) async {
    var result = await _execQuery(
      'INSERT INTO users (name, email, password) VALUES (?, ?, ?)',
      [value.name, value.email, value.password],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _execQuery('DELETE FROM users WHERE id = ?', [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    var result = await _execQuery('SELECT * FROM users');
    return result
        .map((r) => UserModel.fromMap(r.fields))
        .toList()
        .cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    var result = await _execQuery('SELECT * FROM users WHERE id = ?', [id]);
    return result.affectedRows == 0
        ? null
        : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _execQuery(
      'UPDATE users SET name = ?, password = ? WHERE id = ?',
      [value.name, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  _execQuery(String sql, [List? params]) async {
    var conn = await _dbConfiguration.connection;
    return await conn.query(sql, params);
  }
}
