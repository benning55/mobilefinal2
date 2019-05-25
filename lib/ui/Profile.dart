import 'package:flutter/material.dart';
import 'package:mobilefinal2/dbms/DatabaseManage.dart';
import 'package:mobilefinal2/models/Users.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Home.dart';
import 'LogIn.dart';

class Profile extends StatefulWidget {
  Users userInfo;
  Profile(this.userInfo);

  @override
  ProfileState createState() {
    // TODO: implement createState
    return ProfileState(userInfo);
  }
}

class ProfileState extends State<Profile> {

  Users userInfo;
  ProfileState(this.userInfo);

  TextEditingController useridControl = TextEditingController();
  TextEditingController usernameControl = TextEditingController();
  TextEditingController ageControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  TextEditingController quoteControl = TextEditingController();
  DatabaseManage db = DatabaseManage();

  

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int checkspace(String text){
    int space = 0;
    for (int i = 0; i < text.length ; i ++){
      if (text[i] == ' '){
        space++;
      }
    }
    return space;
  }

  TextFormField userId() {
    return TextFormField(
      controller: useridControl,
      decoration: InputDecoration(
        labelText: "User Id",
        hintText: "charecter length between 6 to 12",
        icon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.length < 6 || value.length > 12 || value.contains(' ')) {
          return "Please input correct valid userId";
        }
      },
    );
  }

  TextFormField userName() {
    return TextFormField(
      controller: usernameControl,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Abc Reddicks",
        icon: Icon(Icons.account_circle),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if (checkspace(value) != 1){
          return "Name must contain only 1 spacebar";
        }
      },
    );
  }

  TextFormField userAge() {
    return TextFormField(
      controller: ageControl,
      decoration: InputDecoration(
        labelText: "Age",
        hintText: "10 - 80 years old",
        icon: Icon(Icons.calendar_today),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (int.parse(value) == null ||
            (int.parse(value) < 10 || int.parse(value) > 80)) {
          return "Please input correct age value";
        }
      },
      obscureText: false,
    );
  }

  TextFormField password() {
    return TextFormField(
      controller: passControl,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "need more than 6 characters",
          icon: Icon(Icons.lock)),
      obscureText: true,
      validator: (value) {
        if (value.length < 6) {
          return "Password length must more than 6 character.";
        }
      },
    );
  }

  //Quote Field
  TextFormField quote(){
    return TextFormField(
      controller: quoteControl,
      maxLines: 5,
      decoration: InputDecoration(
          labelText: "quote",
          hintText: "quote"),
      validator: (value) {},
    );
  }

  RaisedButton saves() {
    return RaisedButton(
      child: Text(
        "SAVE",
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          if (passControl.text == "" ||
              usernameControl.text == "" ||
              useridControl.text == "" ||
              ageControl.text == "" ||
              quoteControl.text == "") {
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
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
          } else {
            Users udUser = new Users();
            udUser.setUsers(userInfo.id, useridControl.text, usernameControl.text, ageControl.text, passControl.text, quoteControl.text);
            db.updateUsers(udUser);
            Alert(
              context: context,
              type: AlertType.success,
              title: "Success",
              desc: "Your Update have been Success.",
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => Home(udUser)
                    ));
                  },
                  width: 120,
                )
              ],
            ).show();
            
          }
        }
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(32.0),
            shrinkWrap: true,
            children: <Widget>[
              userId(),
              userName(),
              userAge(),
              password(),
              quote(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0
                ),
                child: saves()
              ),
            ],
          ),
        ),
      ),
    );
  }
}