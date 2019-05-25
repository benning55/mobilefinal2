import 'package:flutter/material.dart';
import 'package:mobilefinal2/ui/Friend.dart';
import 'package:mobilefinal2/ui/Process.dart';


import 'models/Users.dart';
import 'ui/LogIn.dart';
import 'ui/Register.dart';


void main() => runApp(MyApp());

List<Users> items = new List();


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xffa1887f),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Process(),
        "/register": (context) => Register(),
        "/login": (context) => LogIn(),
      },
    );
  }
}


