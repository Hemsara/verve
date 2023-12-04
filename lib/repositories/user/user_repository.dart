import 'package:verve/api/api_service.dart';
import 'package:verve/api/endpoints.dart';
import 'package:verve/models/api/response.dart';
import 'package:verve/models/user/account_user.dart';
import 'package:verve/models/user/user.dart';
import 'package:verve/models/user/user_search_result.dart';
import 'package:verve/repositories/user/user_interface.dart';

class UserRepository extends IUserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  @override
  Future<User> getCurrentUser() async {
    try {
      ApiResponse response = await _apiService.get(
        endpoint: EndPoints.currentUSER,
        mustAuthenticated: true,
      );
      return User.fromMap(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> followUser(int userID) async {
    try {
      ApiResponse response = await _apiService.post(
        data: {},
        endpoint: EndPoints.followUser(userID),
        mustAuthenticated: true,
      );
      return response.status == RequestStatus.success;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AccountUser> getUserInfo(int userID) async {
    try {
      ApiResponse response = await _apiService.get(
        endpoint: EndPoints.getUser(userID),
        mustAuthenticated: true,
      );
      return AccountUser.fromMap(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserSearchResult>> searchUser(String params) async {
    try {
      ApiResponse response = await _apiService.get(
        endpoint: EndPoints.searchUser(params),
        mustAuthenticated: true,
      );
      return (response.data['data'] as List)
          .map((e) => UserSearchResult.fromMap(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> unfollowUser(int userID) async {
    try {
      ApiResponse response = await _apiService.post(
        data: {},
        endpoint: EndPoints.unfollowUser(userID),
        mustAuthenticated: true,
      );
      return response.status == RequestStatus.success;
    } catch (e) {
      rethrow;
    }
  }
}
