import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/body.dart';

class SignUpScreen extends StatefulWidget {

  List InstituteList;

  SignUpScreen({
    Key key,
    @required this.InstituteList,

  }) : super(key: key);
  @override
  _SignUpState createState() =>
      _SignUpState(InstituteList);
}

class _SignUpState extends State<SignUpScreen> {

  List InstituteList;


  _SignUpState(this.InstituteList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(InstituteList: InstituteList),
    );
  }
}
