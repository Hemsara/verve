import 'package:verve/api/api_service.dart';
import 'package:verve/api/endpoints.dart';
import 'package:verve/models/api/response.dart';
import 'package:verve/models/auth/user_auth.dart';
import 'package:verve/repositories/auth/auth_interface.dart';

class AuthRepository extends IAuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  @override
  Future<bool> register(UserRegisterModel userRegisterModel) async {
    try {
      ApiResponse response = await _apiService.post(
        data: userRegisterModel.toMap(),
        endpoint: EndPoints.register,
        mustAuthenticated: false,
      );

      return response.status == RequestStatus.success;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> login(UserLoginModel userLoginModel) async {
    try {
      ApiResponse response = await _apiService.post(
        data: userLoginModel.toMap(),
        endpoint: EndPoints.login,
        mustAuthenticated: false,
      );
      return response.data['token'];
    } catch (e) {
      rethrow;
    }
  }
}
