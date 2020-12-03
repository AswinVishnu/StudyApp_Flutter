import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/exam.dart';
import 'package:flutter_auth/Models/question.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/Screens/Practice_Tests/components/exampage.dart';

class PracticeTestsScreen extends StatefulWidget {
  final List userList;
  bool isLoading;
  final List<Exam> examList;
  PracticeTestsScreen({
    Key key,
    @required this.userList,
    @required this.examList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _PracticeTestsState createState() =>
      _PracticeTestsState(userList, examList, isLoading);
}

class _PracticeTestsState extends State<PracticeTestsScreen> {
  List userList;
  var isLoading;
  List<Exam> examList;

  _PracticeTestsState(this.userList, this.examList, this.isLoading);
  @override
  Widget customcard(String examName, String des, Exam exam) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                ExamSetup(examName, exam, examList, isLoading, userList),
          ));
        },
        child: Material(
          color: Color(0xFF6F35A5),
          //color: Colors.deepPurple[400],
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                ),
                Center(
                  child: Text(
                    examName,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "Alike"),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text('Practice Test'),
      ),
      drawer: NavDrawer(userList: userList),
      body: (isLoading == true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Background(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var item in examList)
                      customcard(
                          item.name ?? "", item.description ?? "", item ?? "")
                  ],
                ),
              ),
            ),
    );
  }
}
