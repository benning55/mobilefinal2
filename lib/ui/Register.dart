import 'package:flutter/material.dart';
import 'package:mobilefinal2/dbms/DatabaseManage.dart';
import 'package:mobilefinal2/models/Users.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'LogIn.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController useridControl = TextEditingController();
  TextEditingController usernameControl = TextEditingController();
  TextEditingController ageControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  DatabaseManage db = DatabaseManage();

  List<Users> items = new List();

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

  RaisedButton regis() {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      splashColor: Colors.blueGrey,
      child: Text(
        "REGISTER NEW ACCOUNT",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          if (passControl.text == "" ||
              ageControl.text == "" ||
              useridControl.text == "" ||
              usernameControl.text == "") {
            
          } else {
            bool state = true;
            var x = await db.checkExistUser();
            for(int i = 0; i < x.length; i++){
              if(x[i].userid == useridControl.text){
                print(x[i].userid);
                print(useridControl.text);
                state = false;
              }
            }
            print(state);
            if(!state){
              Alert(
              context: context,
              type: AlertType.error,
              title: "Error",
              desc: "This userid have been used.",
                buttons: [
                  DialogButton(
                   child: Text(
                      "OK",
                     style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  onPressed: (){
                     Navigator.push(context, 
                     MaterialPageRoute(
                        builder: (context) => Register()
                     ));
                    },
                    width: 120,
                  )
                ],
              ).show();
            }else{
              Users test = new Users();
              test.goCreate(useridControl.text, usernameControl.text, ageControl.text, passControl.text);
              db.saveNewUsers(test);
              Alert(
                context: context,
                type: AlertType.success,
                title: "Success",
                desc: "Your account have been create.",
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
            }
            
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
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0
                ),
                child: regis()
              ),
            ],
          ),
        ),
      ),
    );
  }
}