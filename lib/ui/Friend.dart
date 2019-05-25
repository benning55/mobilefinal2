import 'package:flutter/material.dart';
import 'package:mobilefinal2/models/Users.dart';

import 'Home.dart';

class Friend extends StatefulWidget {
  Users userInfo;
  Friend(this.userInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FriendState(userInfo);
  }

}



class FriendState extends State<Friend>{
  Users userInfo;
  FriendState(this.userInfo);


  RaisedButton back(){
    return RaisedButton(
      child: Text("BACK"),
      onPressed: (){
        Navigator.push(context, 
          MaterialPageRoute(
          builder: (context) => Home(userInfo)
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),

      body: SingleChildScrollView(
        child: ListView(
          padding: EdgeInsets.all(20.0),
          shrinkWrap: true,
          children: <Widget>[
            back()
          ],
        ),
      ),
    );
  }
}