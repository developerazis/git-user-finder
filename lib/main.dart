import 'package:flutter/material.dart';
import 'package:github_user_finder_app/providers/user_provider.dart';
import 'package:github_user_finder_app/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
        child: HomeScreen(),
      ),
    );
  }
}
