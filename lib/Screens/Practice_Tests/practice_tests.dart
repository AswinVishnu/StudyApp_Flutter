import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/exam.dart';
import 'package:flutter_auth/Models/question.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/Screens/Practice_Tests/components/exampage.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';

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
              child: ListView.builder(
                  itemCount: examList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        splashColor: Colors.blue,
                        highlightColor: Colors.blue.withOpacity(0.9),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => ExamSetup(
                                examList[index].name,
                                examList[index],
                                examList,
                                isLoading,
                                userList),
                          ));
                        },
                        child: ListItem(examList[index]));
                  }),
            ),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }

  Widget ListItem(Exam listItem) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          ListTile(
            leading: Icon(Icons.access_alarm_sharp, size: 30),
            title: Text(listItem.name, style: TextStyle(fontSize: 20.0)),
            trailing: Icon(Icons.arrow_right_outlined, size: 30),
          ),
        ],
      ),
    );
  }
}
