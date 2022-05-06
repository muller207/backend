import 'dart:convert';

class NewsModel {
  int? id;
  String? title;
  String? description;
  DateTime? publicationDate;
  DateTime? updateDate;
  int? userId;

  NewsModel();

  /*factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..publicationDate = map['dt_creation']
      ..updateDate = map['dt_update']
      ..userId = map['id_user'];
  }*/

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, publicationDate: $publicationDate, updateDate: $updateDate)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (publicationDate != null) {
      result
          .addAll({'publicationDate': publicationDate!.millisecondsSinceEpoch});
    }
    if (updateDate != null) {
      result.addAll({'updateDate': updateDate!.millisecondsSinceEpoch});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }

    return result;
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel()
      ..id = map['id']?.toInt()
      ..title = map['title']
      ..description = map['description'].toString()
      ..publicationDate = map['publicationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['publicationDate'])
          : null
      ..updateDate = map['updateDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updateDate'])
          : null
      ..userId = map['userId']?.toInt();
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));
}
