import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:verve/api/api_service.dart';
import 'package:verve/models/api/error.dart';
import 'package:verve/models/auth/user_auth.dart';
import 'package:verve/repositories/auth/auth_repository.dart';

// managing the authentication state of the app.
class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository(ApiService());

  // This property stores the error message that occurred during sign-up attempts
  String? _signUpError;
  String? get signUpError => _signUpError;

  // This property stores the error message that occurred during login attempts
  String? _loginError;
  String? get loginError => _loginError;

  // This method attempts to register a new user
  Future<bool> registerUser(UserRegisterModel registerModel) async {
    try {
      bool isRegistered = await _authRepository.register(registerModel);
      return isRegistered;
    } on ApiError catch (e) {
      _signUpError = (e).message;
      return false;
    } catch (e) {
      _signUpError = "Something went wrong";
      return false;
    }
  }

  Future<bool> loginUser(UserLoginModel userLoginModel) async {
    try {
      //  will receive a token if everything went well
      String token = await _authRepository.login(userLoginModel);

      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      await secureStorage.write(key: "token", value: token);
      return true;
    } on ApiError catch (e) {
      _loginError = (e).message;
      return false;
    } catch (e) {
      _loginError = "Unable to login";
      return false;
    }
  }
}
