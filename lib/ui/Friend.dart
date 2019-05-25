import 'package:flutter/material.dart';

class Friend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FriendState();
  }

}



class FriendState extends State<Friend>{

  RaisedButton back(){
    return RaisedButton(
      child: Text("BACK"),
      onPressed: (){
        Navigator.pop(context);
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