import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:verve/models/api/error.dart';
import 'package:verve/res/navigator.dart';
import 'package:verve/views/auth/screens/login_screen.dart';

class BaseApiService {
  Future<Map<String, String>> getHeaders(bool mustAuthenticated) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (mustAuthenticated) {
      try {
        // Retrieve the authentication token from secure storage
        const storage = FlutterSecureStorage();
        String? token = await storage.read(key: 'token');
        headers['Authorization'] = 'Bearer $token';
      } catch (e) {
        return headers;
      }
    }
    return headers;
  }

  void handleUnAuthenticated(statusCode, bool mustAuthenticated) {
    if (statusCode == 401) {
      if (mustAuthenticated) {
        NavigatorHelper.replaceAll(const LoginScreen());
      }
    }
  }
}
