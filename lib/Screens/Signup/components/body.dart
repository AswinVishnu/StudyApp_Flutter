import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}
class _SignUpPageState extends State<Body> {

  String fullname;
  String mobile;
  String email;
  String password;
  Item selectedUser;

  List<Item> users = <Item>[
    const Item('Scholars Academy, Mundakkayam',Icon(Icons.android,color:  Color(0xFF6F35A5),)),
    const Item('Brillaince Accademy, Pala',Icon(Icons.flag,color:  Color(0xFF6F35A5),)),
    const Item('PC Thomas Insititute, Thrissur',Icon(Icons.format_indent_decrease,color:  Color(0xFF6F35A5),)),
    const Item('Study Internationals, Kollam',Icon(Icons.mobile_screen_share,color:  Color(0xFF6F35A5),)),
  ];

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    signUp(String fullname, mobile,email,institute,password) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      Map data = {
        "fullname":fullname,
        "institute":institute,
        "email":email,
        "mobile":mobile,
        "password":password,
        "role":"student"
      };
      var jsonResponse = null;
      var response = await http.post("https://oxystech-study-app-nodejs.herokuapp.com/user/account", body: data);
      if(response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if(jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });
          //sharedPreferences.setString("token", jsonResponse['token']);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginScreen ()), (Route<dynamic> route) => false);
          print("Added new account Successfully");
        }
      }
      else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);

      }
    }
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Full Name",
              onChanged: (value) {
                fullname=value;
                },
            ),
            RoundedInputField(
              hintText: "Mobile(+91)",
              onChanged: (value) {mobile=value ;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {email=value ;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {password=value ;
             },
            ),

            SizedBox(height: size.height * 0.01),
            Container(

              padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 7.0),

              decoration: BoxDecoration(
                color: Color(0xFFF1E6FF),
                borderRadius: BorderRadius.circular(30.0),

              ),
              child: DropdownButton(
                hint:  Text("Select item"),
                value: selectedUser,
                onChanged: (Item Value) {
                  setState(() {
                    selectedUser = Value;
                  });
                },
                items: users.map((Item user) {
                  return  DropdownMenuItem<Item>(
                  value: user,
                  child: Row(
                  children: <Widget>[
                  user.icon,
                  SizedBox(width: 10,),
                  Text(
                  user.name,
                  style:  TextStyle(color: Colors.black54),
                  ),
                  ],
                  ),
                  );
                  }).toList(),
                )),


            SizedBox(height: size.height * 0.01),


            RoundedButton(
              text: "SIGNUP",
              press: () {
                   signUp(fullname, mobile,email,selectedUser.name,password);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
