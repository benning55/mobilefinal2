import 'package:flutter/material.dart';
import 'package:mobilefinal2/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Friend.dart';
import 'LogIn.dart';
import 'Profile.dart';


class Home extends StatefulWidget{

  Users userInfo;
  Home(this.userInfo);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState(userInfo);
  }

}

class HomeState extends State<Home>{
  Users userInfo;
  HomeState(this.userInfo);


  RaisedButton profile(){
    return RaisedButton(
      child: Text(
        "PROFILE SETUP"
      ),
      onPressed: (){
        Navigator.push(context, 
          MaterialPageRoute(
          builder: (context) => Profile(userInfo)
        ));
      },
    );
  }

  RaisedButton myfriend(){
    return RaisedButton(
      child: Text(
        "MY FRIENDS"
      ),
      onPressed: (){
        Navigator.push(context, 
          MaterialPageRoute(
          builder: (context) => Friend(userInfo)
        ));
      },
    );
  }

  RaisedButton logout(){
    return RaisedButton(
      child: Text(
        "SIGN OUT"
      ),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        final check = prefs.get('ID') ?? 0;
        print(check);
        prefs.remove('ID');
        Navigator.pushReplacementNamed(context, "/login");
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: SingleChildScrollView(
        child: ListView(
          padding: EdgeInsets.all(32),
          shrinkWrap: true,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0
                ),
                child: Text("Hello "+ userInfo.name.toString()
                +"\n"+"This is my quote "+userInfo.quote.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            profile(),
            myfriend(),
            logout()
          ],
        ),
      ),
    );
  }
}
