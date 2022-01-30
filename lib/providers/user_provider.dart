import 'package:flutter/cupertino.dart';
import 'package:github_user_finder_app/models/all_user.dart';
import 'package:github_user_finder_app/models/user.dart';
import 'package:github_user_finder_app/models/user_find.dart';
import 'package:github_user_finder_app/services/user_services.dart';

class UserProvider with ChangeNotifier {
  bool isSearch = false;
  bool isLastPage = false;
  bool isLoading = true;
  int page = 1;
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  List<User>? listUser;
  int totalUserFinded = 0;
  int totalPage = 0;

  Future fetchAllUser() async {
    isLoading = true;
    notifyListeners();

    if (isSearch) {
      isSearch = true;
      UserFind? _userFind = await UserService()
          .getUser(name: textEditingController.text, page: 0);
      totalUserFinded = _userFind?.totalCount ?? 0;
      totalPage = (totalUserFinded / 30).ceil();
      listUser = _userFind?.users;
    } else {
      isSearch = false;
      AllUser? _allUser = await UserService().getAllUser(since: 0);
      listUser = _allUser?.users;
    }

    isLoading = false;
    notifyListeners();
  }

  scrollListener() async {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isSearch) {
          if (page > 0 && listUser != null) {
            page = listUser!.last.id!;
          }
          AllUser? _allUser = await UserService().getAllUser(since: page);
          if (_allUser != null) {
            listUser!.addAll(_allUser.users!);
          }
        } else {
          if (page < totalPage) {
            isLastPage = false;
            page++;
            UserFind? _userFind = await UserService()
                .getUser(name: textEditingController.text, page: page);
            totalUserFinded = _userFind?.totalCount ?? 0;
            if (_userFind != null) {
              listUser!.addAll(_userFind.users!);
            }
          } else {
            isLastPage = true;
          }
        }
        notifyListeners();
      }
    });
  }
}
