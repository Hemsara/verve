import 'package:verve/models/post/post.dart';
import 'package:verve/models/user/user.dart';

class AccountUser extends User {
  final bool isFollowing;

  AccountUser({
    required this.isFollowing,
    required super.id,
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.posts,
    required super.bio,
    required super.followersCount,
    required super.followingCount,
  });
  factory AccountUser.fromMap(Map<String, dynamic> map) {
    return AccountUser(
      isFollowing: map['isFollowing'],
      id: map['id'],
      bio: map['bio'],
      username: map['username'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      posts: List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
      followersCount: map['_count']['following'],
      followingCount: map['_count']['followers'],
    );
  }
}
