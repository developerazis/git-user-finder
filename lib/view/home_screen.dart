import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_user_finder_app/models/user.dart';
import 'package:github_user_finder_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<UserProvider>(context, listen: false).scrollListener();
    Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false).fetchAllUser();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: _userProvider.scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            title: Text("Github User Finder"),
            backgroundColor: Colors.blue[900],
            bottom: AppBar(
              backgroundColor: Colors.blue[900],
              title: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextField(
                          controller: _userProvider.textEditingController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Search User',
                            isDense: true,
                            filled: true,
                            prefixIcon: Icon(Icons.search),
                            fillColor: Colors.white,
                          ),
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_userProvider.textEditingController.text != "") {
                          _userProvider.isSearch = true;
                          _userProvider.page = 1;
                        } else {
                          _userProvider.isSearch = false;
                          _userProvider.page = 0;
                        }
                        _userProvider.fetchAllUser();
                      },
                      child: Container(
                          decoration: BoxDecoration(),
                          height: 50,
                          child: Center(child: Text("Search"))),
                      style: ElevatedButton.styleFrom(primary: Colors.orange),
                    )
                  ],
                ),
              ),
            ),
          ),
          Consumer<UserProvider>(
              child: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 40,
                    width: 0,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }, childCount: 6)),
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return child!;
                }
                if (provider.listUser == null) {
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Icon(
                          Icons.web_asset_off,
                          size: 120,
                        ),
                      ),
                    )
                  ]));
                }
                return SliverList(
                    delegate: SliverChildListDelegate([
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.listUser?.length ?? 0,
                    itemBuilder: (context, index) {
                      User _user = provider.listUser![index];
                      return ListTile(
                        title: Text(_user.login.toString()),
                        leading: Image.network(_user.avatarUrl.toString()),
                        trailing: Text(_user.id.toString()),
                      );
                    },
                  ),
                  (provider.isLastPage)
                      ? Container()
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                ]));
                // return SliverList(
                //     delegate: SliverChildBuilderDelegate(
                //   (context, index) {
                //     User _user = provider.listUser![index];
                //     return ListTile(
                //       title: Text(_user.login.toString()),
                //       leading: Image.network(_user.avatarUrl.toString()),
                //     );
                //   },
                //   childCount: provider.listUser?.length ?? 0,
                // ));
              })
        ],
      ),
    );
  }
}
