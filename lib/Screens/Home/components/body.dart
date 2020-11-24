import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/Screens/Home/components/griddashboard.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: <Widget>[

          SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}
