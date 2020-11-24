import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Question_Bank/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class QuestionBankScreen extends StatefulWidget {
  List userList;
  QuestionBankScreen({
    Key key,
    @required this.userList,
  }) : super(key: key);
  @override
  _QuestionBankState createState() => _QuestionBankState(userList);
}

class _QuestionBankState extends State<QuestionBankScreen> {
  List userList;

  _QuestionBankState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Question bank'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(),
    );
  }
}
