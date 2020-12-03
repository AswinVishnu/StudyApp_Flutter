import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/exam.dart';
import 'package:flutter_auth/Screens/Study_Materials/study_materials.dart';
import 'package:flutter_auth/Screens/Home/home.dart';
import 'package:flutter_auth/Screens/Question_Bank/question_bank.dart';
import 'package:flutter_auth/Screens/Current_Affairs/current_affairs.dart';
import 'package:flutter_auth/Screens/Practice_Tests/practice_tests.dart';

import 'package:flutter_auth/Screens/Profile/edit_profile.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/Perfomance/perfomance.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_auth/Screens/Video/video_screen.dart';
import 'package:flutter_auth/Screens/Audio/audio_screen.dart';
import 'package:flutter_auth/components/question.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//import 'package:flutter_auth/components/currentaffairs.dart';
//import 'package:flutter_auth/components/audio.dart';
//import 'package:flutter_auth/components/video.dart';
import 'package:flutter_auth/Screens/Notes/notes_screen.dart';
import 'package:flutter_auth/models/contents.dart';
import 'package:flutter_auth/models/configuration.dart';

class NavDrawer extends StatefulWidget {
  final List userList;

  NavDrawer({Key key, @required this.userList}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState(userList);
}

class _NavDrawerState extends State<NavDrawer> {
  List<Question> list = List();
  List<Exam> examResponse = List();
  List<Question> questionsList = List();
  List<Contents> currentAffairsList = List();
  List<Contents> videosList = List();
  List<Contents> audiosList = List();
  List<Contents> notesList = List();
  var isLoading = false;
  List userList;

  _NavDrawerState(this.userList);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.lightBlue[900],
      child: new Column(children: <Widget>[
        Container(
          color: Colors.lightBlue[900],
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                  ),
                  CircleAvatar(
                    backgroundColor: primaryGreen,
                    radius: 30,
                    backgroundImage: new ExactAssetImage(
                        'assets/images/profile.jpg')
                  ),
                  ],
              ),
                  // Icon(
                  //   FontAwesomeIcons.userAlt,
                  //   color: primaryGreen,
                  //   size: 40,
              Row(
                children: [  // ),
                  SizedBox(
                    width: 130,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userList[1],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17),
                      ),
                      Text(userList[3],
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 17))
                    ],
                  )
                ],
              ),

              SizedBox(
                height: 40,
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        new ListTile(
          title: new Text('Home',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(userList: userList)),
            );
          },
        ),
        new ListTile(
          title: new Text('Current Affairs',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Icon(
            Icons.pages,
            color: Colors.white,
          ),
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            final response = await http.get(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/current_affairs");
            if (response.statusCode == 200) {
              currentAffairsList = (json.decode(response.body) as List)
                  .map((data) => new Contents.fromJson(data))
                  .toList();
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CurrentAffairsScreen(
                        userList: userList,
                        currentAffairsList: currentAffairsList,
                        isLoading: isLoading)),
              );
            } else {
              throw Exception('Failed to load quetions');
            }
          },
        ),
        new ListTile(
          leading: Icon(
            Icons.book,
            color: Colors.white,
          ),
          title: new Text('Study Materials',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      StudyMaterialsScreen(userList: userList)),
            );
          },
        ),
        new ListTile(
          title: new Text('Practice Tests',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Icon(
            Icons.accessibility_new,
            color: Colors.white,
          ),
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            final response = await http.get(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/exam");
            if (response.statusCode == 200) {
              Map<String, dynamic> map = json.decode(response.body);
              examResponse = (map["result"] as List)
                  .map((data) => new Exam.fromJson(data))
                  .toList();
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PracticeTestsScreen(
                        userList: userList,
                        examList: examResponse,
                        isLoading: isLoading)),
              );
            } else {
              throw Exception('Failed to load photos');
            }
          },
        ),
        new ListTile(
          title: new Text('Question Bank',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Icon(
            Icons.flag,
            color: Colors.white,
          ),
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            final response = await http.get(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/question");
            if (response.statusCode == 200) {
              questionsList = (json.decode(response.body) as List)
                  .map((data) => new Question.fromJson(data))
                  .toList();
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionBankScreen(
                        userList: userList,
                        questionList: questionsList,
                        isLoading: isLoading)),
              );
            } else {
              throw Exception('Failed to load quetions');
            }
          },
        ),
        new ListTile(
          title: new Text('Perfomance',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Icon(
            Icons.backpack,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PerfomanceScreen(userList: userList)),
            );
          },
        ),
        new ListTile(
          title: new Text('Edit Profile',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Icon(
            FontAwesomeIcons.userAlt,
            color: Colors.white,
          ),
          onTap: () async {
            var jsonResponse;
            var response = await http.get(
                "https://oxystech-study-app-nodejs.herokuapp.com/user/account/" +
                    userList[0]);
            if (response.statusCode == 200) {
              jsonResponse = json.decode(response.body);
              List newList = [];
              newList.add(jsonResponse['result']['_id']);
              newList.add(jsonResponse['result']['fullname']);
              newList.add(jsonResponse['result']['mobile'].toString());
              newList.add(jsonResponse['result']['email']);
              newList.add(jsonResponse['result']['password']);
              if (jsonResponse != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfileScreen(userList: newList)),
                );
              }
            }
          },
        ),
        SizedBox(
          height: 40,
        ),
        new ListTile(
          title: new Text('SignOut',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          },
        ),
      ]),
    ));
  }
}
