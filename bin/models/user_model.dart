import 'package:password_dart/password_dart.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  DateTime? dtCreation;
  DateTime? dtUpdate;

  UserModel();

  UserModel.create(this.id, this.name, this.email, this.isActive,
      this.dtCreation, this.dtUpdate);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
      map['email'] ?? '',
      map['is_active'] == 1,
      map['dt_creation'],
      map['dt_update'],
    );
  }

  factory UserModel.fromRequest(Map<String, dynamic> map) {
    return UserModel()
      ..name = map['name']
      ..email = map['email']
      ..password = Password.hash(map['password'], PBKDF2());
  }

  factory UserModel.fromEmail(Map<String, dynamic> map) {
    return UserModel()
      ..id = map['id']?.toInt()
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isActive: $isActive, dtCreation: $dtCreation, dtUpdate: $dtUpdate)';
  }
}
