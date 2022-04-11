import 'dart:convert';

class NewsModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime publicationDate;
  final DateTime? updateDate;

  NewsModel(
    this.id,
    this.title,
    this.description,
    this.image,
    this.publicationDate,
    this.updateDate,
  );

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, image: $image, publicationDate: $publicationDate, updateDate: $updateDate)';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'image': image});
    result.addAll({'publicationDate': publicationDate.millisecondsSinceEpoch});
    if (updateDate != null) {
      result.addAll({'updateDate': updateDate!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      map['id']?.toInt(),
      map['title'] ?? '',
      map['description'] ?? '',
      map['image'] ?? '',
      DateTime.fromMillisecondsSinceEpoch(map['publicationDate']),
      map['updateDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updateDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));
}
