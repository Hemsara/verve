import 'dart:convert';

import 'package:verve/models/post/post.dart';

class User {
  int id;
  String username;
  String email;
  String? profilePicture;
  String firstName;
  String lastName;

  String? bio;
  List<Post> posts;
  int followersCount;
  int followingCount;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.profilePicture,
    required this.firstName,
    required this.lastName,
    this.bio,
    required this.posts,
    required this.followersCount,
    required this.followingCount,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profilePicture: map['profilePicture'],
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      bio: map['bio'],
      posts: List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
      followersCount: map['_count']['following']?.toInt() ?? 0,
      followingCount: map['_count']['followers']?.toInt() ?? 0,
    );
  }
}
