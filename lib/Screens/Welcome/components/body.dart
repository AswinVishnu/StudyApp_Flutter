import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/models/institute.dart';

class Body extends StatelessWidget {

  List<Institute> InstituteList = List();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LET'S LEARN",
              style: GoogleFonts.abrilFatface(textStyle: TextStyle(color: Colors.lightBlue[900], fontSize: 30, letterSpacing: .9)),
            ),

            Image.asset(
              "assets/images/boy.jpg",
              height: size.height * 0.45,
            ),
            // SvgPicture.asset(
            //   "assets/icons/chat.svg",
            //   height: size.height * 0.45,
            // ),

            RoundedButton(
              text: "LOGIN",
              color: Colors.lightBlue[900],
              textColor: Colors.white,

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
            RoundedButton(
              text: "SIGN UP",
              color: Colors.blueGrey,
              textColor: Colors.white,
              press: () async{

                var notResponse = await http.get(
                "https://oxystech-study-app-nodejs.herokuapp.com/user/list/admin");


                if (notResponse.statusCode == 200) {
                  InstituteList = (json.decode(notResponse.body) as List)
                      .map((data1) => new Institute.fromJson(data1))
                      .toList();

                  print(json.decode(notResponse.body));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen(
                            InstituteList: InstituteList)),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
