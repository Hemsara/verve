import 'package:flutter/material.dart';
import 'package:verve/api/api_service.dart';
import 'package:verve/models/api/error.dart';
import 'package:verve/models/user/account_user.dart';
import 'package:verve/models/user/user.dart';
import 'package:verve/models/user/user_search_result.dart';
import 'package:verve/repositories/user/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository(ApiService());

  User? _currentUser;
  User? get currentUser => _currentUser;

  bool _currentUserFetching = false;
  bool get currentUserFetching => _currentUserFetching;

  String? _currentUserFetchingError;
  String? get currentUserFetchingError => _currentUserFetchingError;

  String? _followUserError;
  String? get followUserError => _followUserError;

  Future<bool> makeProfileRequest(int userID, bool isFollowing) async {
    try {
      return isFollowing
          ? await _userRepository.unfollowUser(userID)
          : await _userRepository.followUser(userID);
    } on ApiError catch (e) {
      _followUserError = e.message;
      return false;
    } catch (e) {
      _followUserError =
          "Unable to ${isFollowing ? "Unfollow" : "follow"} user";
      return false;
    } finally {
      notifyListeners();
    }
  }

  getCurrentUserData() async {
    try {
      _currentUser = null;
      _currentUserFetching = true;

      User user = await _userRepository.getCurrentUser();
      _currentUser = user;
    } on ApiError catch (e) {
      _currentUserFetchingError = e.message;
    } catch (e) {
      _currentUserFetchingError = "Unable to fetch user";
    } finally {
      _currentUserFetching = false;
      notifyListeners();
    }
  }

  Future<AccountUser?> getUserInfo(int userID) async {
    try {
      return await _userRepository.getUserInfo(userID);
    } catch (e) {
      return null;
    }
  }

  Future<List<UserSearchResult>> searchUser(String params) async {
    try {
      return _userRepository.searchUser(params);
    } catch (e) {
      return [];
    }
  }
}
