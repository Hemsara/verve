// login
class UserLoginModel {
  final String email;
  final String password;

  UserLoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}

// register
class UserRegisterModel {
  final String password;
  final String fullName;
  final String email;

  UserRegisterModel({
    required this.password,
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'name': fullName,
      'email': email,
    };
  }
}
