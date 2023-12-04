import 'package:verve/models/user/account_user.dart';
import 'package:verve/models/user/user.dart';
import 'package:verve/models/user/user_search_result.dart';

abstract class IUserRepository {
  Future<User> getCurrentUser();
  Future<bool> followUser(int userID);
  Future<bool> unfollowUser(int userID);

  Future<AccountUser> getUserInfo(int userID);
  Future<List<UserSearchResult>> searchUser(String params);
}
 