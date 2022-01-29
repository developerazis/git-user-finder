import 'package:dio/dio.dart';
import 'package:github_user_finder_app/helpers/url_constant.dart';
import 'package:github_user_finder_app/models/all_user.dart';
import 'package:github_user_finder_app/models/user_find.dart';

class UserService {
  Dio _dio = Dio();

  Future<AllUser?> getAllUser({int since = 1, int perPage = 30}) async {
    Response? _response;
    AllUser? _allUser;
    try {
      _response = await _dio.get(UrlConstant().getAllUser(since, perPage));
      _allUser = AllUser.fromJson(_response.data);

      return _allUser;
    } catch (e) {
      print(e);
    }
  }

  Future<UserFind?> getUser(
      {required name, int page = 1, int perPage = 30}) async {
    Response? _response;
    UserFind? userFind;
    try {
      _response = await _dio.get(UrlConstant().getUser(name, page, perPage));
      userFind = UserFind.fromJson(_response.data);

      return userFind;
    } catch (e) {
      print(e);
    }
  }
}
