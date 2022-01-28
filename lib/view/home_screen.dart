import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
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
                        onPressed: () {},
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
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  child: Text(index.toString()),
                );
              },
              childCount: 100,
            ))
          ],
        ),
      ),
    );
  }
}
