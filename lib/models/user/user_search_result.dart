class UserSearchResult {
  final int id;
  final String firstName;
  final String lastName;

  final String? avatar;

  UserSearchResult({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory UserSearchResult.fromMap(Map<String, dynamic> map) {
    return UserSearchResult(
      id: map['id']?.toInt() ?? 0,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      avatar: map['profile_picture'],
    );
  }
}
