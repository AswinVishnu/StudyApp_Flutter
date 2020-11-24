import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/Home/home.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Body> {
  var email;
  var password;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    signIn(var email, pass) async {
      // SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      Map data = {'email': email, 'password': pass, 'role': 'student'};
      var jsonResponse = null;
      var response = await http.post(
          "https://oxystech-study-app-nodejs.herokuapp.com/user/login",
          body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          // sharedPreferences.setString("token", jsonResponse['token']);
          List<String> userList = [];

          userList.add(jsonResponse['_id']);
          userList.add(jsonResponse['fullname']);
          userList.add(jsonResponse['mobile'].toString());
          userList.add(jsonResponse['email']);
          userList.add(jsonResponse['password']);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomeScreen(userList: userList)),
              (Route<dynamic> route) => false);
          print("Logged in Successfully");
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }

    return Background(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Your Email",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      signIn(email, password);
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
