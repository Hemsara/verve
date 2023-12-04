import 'dart:convert';

class Post {
  int id;
  String title;
  String subtext;
  String body;
  DateTime createdAt;
  PostUser user;
  int commentsCount;
  int likesCount;
  List<String> tags;

  Post({
    required this.id,
    required this.title,
    required this.subtext,
    required this.body,
    required this.createdAt,
    required this.user,
    required this.commentsCount,
    required this.likesCount,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtext': subtext,
      'body': body,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'commentsCount': commentsCount,
      'likesCount': likesCount,
      'tags': tags,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      user: PostUser.fromMap(map['user']),
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      subtext: map['subtext'] ?? '',
      body: map['body'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      commentsCount: map['commentsCount']?.toInt() ?? 0,
      likesCount: map['likesCount']?.toInt() ?? 0,
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}

class PostUser {
  final String avatar;
  final String name;
  PostUser({
    required this.avatar,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'name': name,
    };
  }

  factory PostUser.fromMap(Map<String, dynamic> map) {
    return PostUser(
      avatar: map['avatar'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostUser.fromJson(String source) =>
      PostUser.fromMap(json.decode(source));
}
