import 'package:flutter/material.dart';
import 'package:verve/api/api_service.dart';
import 'package:verve/models/api/error.dart';
import 'package:verve/models/auth/user_auth.dart';
import 'package:verve/repositories/auth/auth_repository.dart';
import 'package:verve/res/storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository(ApiService());

  String? _signUpError;
  String? get signUpError => _signUpError;

  String? _loginError;
  String? get loginError => _loginError;

  bool _isLoginIn = false;
  bool get isLoginIn => _isLoginIn;

  bool _isSignInIn = false;
  bool get isSignInIn => _isSignInIn;

  Future<bool> registerUser(UserRegisterModel registerModel) async {
    try {
      _isSignInIn = true;
      notifyListeners();

      bool isRegistered = await _authRepository.register(registerModel);

      return isRegistered;
    } on ApiError catch (e) {
      _signUpError = e.message;
      return false;
    } catch (e) {
      _signUpError = "Something went wrong";
      return false;
    } finally {
      _isSignInIn = false;
      notifyListeners();
    }
  }
  

  Future<bool> loginUser(UserLoginModel userLoginModel) async {
    try {
      _isLoginIn = true;
      notifyListeners();

      String token = await _authRepository.login(userLoginModel);
      SecureStorageHelper secureStorage = SecureStorageHelper();
      await secureStorage.write("token", token);

      return true;
    } on ApiError catch (e) {
      _loginError = e.message;
      return false;
    } catch (e) {
      _loginError = "Unable to login";
      return false;
    } finally {
      _isLoginIn = false;
      notifyListeners();
    }
  }
}
