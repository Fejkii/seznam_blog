import 'dart:convert';

import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 0)
class CommentModel extends HiveObject {
  @HiveField(0)
  int postId;
  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String email;
  @HiveField(4)
  String body;

  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      postId: map['postId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      body: map['body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source));
}
