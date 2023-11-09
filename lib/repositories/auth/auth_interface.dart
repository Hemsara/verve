import 'package:verve/models/auth/user_auth.dart';

abstract class IAuthRepository {
  Future<bool> register(UserRegisterModel userRegisterModel);
}
