import 'package:github_user_finder_app/models/user.dart';

class AllUser {
  List<User>? users;

  AllUser({this.users});

  AllUser.fromJson(json) {
    if (json != null) {
      users = <User>[];
      json.forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
  }

  List toJson() {
    List data = [];
    if (this.users != null) {
      data.addAll(this.users!.map((v) => v.toJson()).toList());
    }
    return data;
  }
}
