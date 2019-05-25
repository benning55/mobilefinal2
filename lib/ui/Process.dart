    
import 'package:flutter/material.dart';
import 'package:mobilefinal2/dbms/DatabaseManage.dart';
import 'package:mobilefinal2/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'LogIn.dart';

class Process extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProcessState();
  }
}

class ProcessState extends State {
  List<Users> items = new List();
  final prefs = SharedPreferences.getInstance();

  DatabaseManage db = DatabaseManage();
  @override
  Future initState() {
    super.initState();
    db.getAllUsers().then((users) {
      setState(() {
        users.forEach((user) {
          items.add(Users.fromMap(user));
        });
        checkLogin();
      });
    });
  }

  Future<String> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final stateLogin = prefs.get('ID') ?? 0;
    if (stateLogin != 0) {
      print("success");
      var dataUser =
          items.singleWhere((i) => i.id == stateLogin, orElse: () => null);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Home(dataUser)));
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}