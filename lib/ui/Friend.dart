import 'package:flutter/material.dart';

class Friend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FriendState();
  }

}

class FriendState extends State<Friend>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend"),
      ),

      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Text("This is Friend page")
            ],
          ),
        ),
      ),
    );
  }
}