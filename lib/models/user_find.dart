import 'package:github_user_finder_app/models/user.dart';

class UserFind {
  late int totalCount;
  bool? incompleteResults;
  List<User>? users;

  UserFind({this.incompleteResults, this.users});

  UserFind.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      users = <User>[];
      json['items'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    data['incomplete_results'] = this.incompleteResults;
    if (this.users != null) {
      data['items'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
