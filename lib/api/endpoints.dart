class EndPoints {
  static String baseURL = "http://localhost:3000/v1";

  // auth
  static String login = "/auth/login";
  static String register = "/auth/register";

  // user
  static String currentUSER = "/users/me";
  static String followUser(int id) => "/users/follow/$id";
  static String unfollowUser(int id) => "/users/unfollow/$id";

  static String getUser(int id) => "/users/user/$id";
  static String searchUser(String params) => "/users/search?username=$params";

  // sso
  static String googleLogin = "/auth/google/login";
  static String googleRegister = "/auth/google/register";
}
