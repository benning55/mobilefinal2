import 'package:flutter/material.dart';
import 'package:mobilefinal2/dbms/DatabaseManage.dart';
import 'package:mobilefinal2/models/Users.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';


class LogIn extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogInState();
  }
}

class LogInState extends State<LogIn>{

  final _formKey = GlobalKey<FormState>();

  TextEditingController useridControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  final prefs = SharedPreferences.getInstance();

  DatabaseManage db = DatabaseManage();
  //UserId Form Text
  TextFormField userId(){
    return TextFormField(
      controller: useridControl,
      decoration: InputDecoration(
        labelText: "User Id",
        hintText: "Enter your user id",
        icon: Icon(Icons.person)
      ),
      keyboardType: TextInputType.text,
      validator: (value){
        
      }
    );
  }

  //Password Form Text
  TextFormField password(){
    return TextFormField(
      controller: passwordControl,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your user id",
        icon: Icon(Icons.https)
      ),
      keyboardType: TextInputType.text,
      validator: (value){
        
      },
      obscureText: true,
    );
  }

  Image img(){
    return Image(
      image: AssetImage("images/1.png"),
      height: 100,
    );
  }

  RaisedButton login(){
    return RaisedButton(
      child: Text("LOGIN"),
      onPressed: () async {
        if(_formKey.currentState.validate()){
          if(useridControl.text.isEmpty || passwordControl.text.isEmpty){
            Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: "Please fill out this form.",
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => LogIn()
                    ));
                  },
                  width: 120,
                )
              ],
            ).show();
          }else{
            var users = await db.getLogInUser(useridControl.text, passwordControl.text);
            if(users == null){
              Alert(
                context: context,
                type: AlertType.error,
                title: "Error",
                desc: "Invalid user or password.",
                buttons: [
                  DialogButton(
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
            }else{
              Users objectUser = new Users();
              objectUser = users[0];
              final prefs = await SharedPreferences.getInstance();
              print(objectUser.id);
              prefs.setInt("ID", users[0].id);
              print("some text");
              print(prefs.getInt('ID') ?? 0);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(objectUser)
                ));
            }
          }
        }
      },
    );
  }

  FlatButton noAccount(){
    return FlatButton(
      child: Text(
        "Register New Account",
        style: TextStyle(color: Colors.blue),
      ),
      onPressed: (){
        Navigator.pushReplacementNamed(context, "/register");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(32.0),
            shrinkWrap: true,
            children: <Widget>[
              img(),
              userId(),
              password(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0
                ),
                child: login()
              ),
              Align(
                alignment: Alignment.centerRight,
                child: noAccount(),
              )
            ],
          ),
        ),
      ),
    );
  }

}