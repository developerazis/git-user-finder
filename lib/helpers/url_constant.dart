class UrlConstant {
  static const String BASE_URL = "https://api.github.com/";
  String getAllUser(since, perPage) =>
      "${BASE_URL}users?since=$since&per_page=$perPage";
}
