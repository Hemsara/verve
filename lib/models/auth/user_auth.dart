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

  final String firstName;
  final String lastName;

  final String email;

  UserRegisterModel({
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'email': email
    };
  }
}
