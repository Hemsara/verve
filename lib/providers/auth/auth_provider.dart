import 'package:flutter/material.dart';
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

  // This method attempts to register a new user
  Future<bool> registerUser(UserRegisterModel registerModel) async {
    try {
      bool isRegistered = await _authRepository.register(registerModel);
      return isRegistered;
    } catch (e) {
      // Handle any errors that occurred during registration.
      if (e.runtimeType == ApiError) {
        // If the error is an API error, extract the error message and store it in the signUpError property.
        _signUpError = (e as ApiError).message;
      } else {
        _signUpError = "Something went wrong";
      }
      return false;
    }
  }
}
