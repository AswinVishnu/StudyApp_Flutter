import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/Screens/Home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/components/bottom_navigation.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {

  ForgotPasswordScreen({Key key}) : super(key: key);
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  List userList;
  String emailId;
  String fullName;
  String currentpassword;
  String newpassword;
  String confirmpassword;
  String mobile;
  _ForgotPasswordScreenState();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text('Forget Password'),
      ),

      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              SizedBox(height: size.height * 0.01),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  emailId = value;
                },
              ),

              RoundedButton(
                color: Colors.lightBlue[900],
                text: "Verify",
                press: () async{

                  Map data = {
                    "email":emailId
                  };
                  // final snackBar =
                  // new SnackBar(content: new Text('Loading...'));
                  // Scaffold.of(context).showSnackBar(snackBar);
                  final response = await http.post(
                      "https://oxystech-study-app-nodejs.herokuapp.com/forgotpassword",
                      body: data);
                  print(json.decode(response.body));
                  if (response.statusCode == 200) {

                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    );
                    AlertDialog alert =  AlertDialog(
                      title: Text("Verified"),
                      content: Text("Your email id is verified. New password is sent to your email."),
                      actions: [
                        okButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                  else{

                    Widget okButton = FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    );
                    AlertDialog alert =  AlertDialog(
                      title: Text("Error"),
                      content: Text("Your account does not exist. Please enter valid email id"),
                      actions: [
                        okButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }

                },
              ),



            ],
          ),
        ),
      ),

    );
  }

}
