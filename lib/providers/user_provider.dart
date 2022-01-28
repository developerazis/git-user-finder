import 'package:flutter/cupertino.dart';
import 'package:github_user_finder_app/models/all_user.dart';
import 'package:github_user_finder_app/models/user.dart';
import 'package:github_user_finder_app/services/user_services.dart';

class UserProvider with ChangeNotifier {
  bool isSearch = false;
  bool isLastPage = false;
  bool isLoading = true;
  int page = 1;
  ScrollController scrollController = ScrollController();
  List<User>? listUser;

  // UserProvider() {
  //   Future.delayed(Duration.zero, () {
  //     fetchAllUser();
  //   });
  // }

  Future fetchAllUser() async {
    isLoading = true;
    notifyListeners();

    AllUser? _allUser = await UserService().getAllUser(since: page);
    listUser = _allUser?.users;

    isLoading = false;
    notifyListeners();
  }
}
