import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/Screens/Study_Materials/study_materials.dart';
import 'package:flutter_auth/Screens/Question_Bank/question_bank.dart';
import 'package:flutter_auth/Screens/Practice_Tests/practice_tests.dart';
import 'package:flutter_auth/Screens/Video/video_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_auth/components/question.dart';
import 'dart:convert';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  _GridDashboardState();
  Items item1 = new Items(
      title: "Current Affairs", img: "assets/images/CurrentAffairs.png");

  Items item2 = new Items(
    title: "Study Materials",
    img: "assets/images/studymaterials.jpg",
  );
  Items item3 = new Items(
    title: "Practice Tests",
    img: "assets/images/exams.png",
  );
  Items item4 = new Items(
    title: "Question Bank",
    img: "assets/images/QuestionBank.jpg",
  );

  @override
  Widget build(BuildContext context) {
    List userList;
    var isLoading = false;
    List<Question> list = List();
    List<Items> myList = [item1, item2, item3, item4];
    var color = 0xff453658;
    return Expanded(
        child: GridView.count(
            padding: EdgeInsets.only(left: 16, right: 16),
            primary: false,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: myList.map((data) {
              return Card(
                elevation: 4,
                color: Colors.white,
                shadowColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      iconSize: 115.0,
                      padding: const EdgeInsets.all(1.0),
                      icon: Image.asset(
                        data.img,
                        width: 190,
                      ),
                      onPressed: () async {
                        if (data.img == "assets/images/CurrentAffairs.png") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return VideoScreen();
                              },
                            ),
                          );
                        } else if (data.img ==
                            "assets/images/studymaterials.jpg") {
                          var response = await http.get(
                              "https://oxystech-study-app-nodejs.herokuapp.com/admin/category");
                          if (response.statusCode == 200) {
                            var jsonResponse = json.decode(response.body);
                            print(jsonResponse);
                            print(jsonResponse['result'][0]['name']);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        StudyMaterialsScreen(
                                          userList: userList,
                                        )),
                                (Route<dynamic> route) => false);
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return StudyMaterialsScreen();
                          //     },
                          //   ),
                          // );
                        } else if (data.img == "assets/images/exams.png") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PracticeTestsScreen(userList: userList);
                              },
                            ),
                          );
                        } else if (data.img ==
                            "assets/images/QuestionBank.jpg") {
                          setState(() {
                            isLoading = true;
                          });
                          final response = await http.get(
                              "https://oxystech-study-app-nodejs.herokuapp.com/admin/question");
                          if (response.statusCode == 200) {
                            list = (json.decode(response.body) as List)
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
                                      questionList: list,
                                      isLoading: isLoading)),
                            );
                          } else {
                            throw Exception('Failed to load photos');
                          }
                        }
                      },
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              );
            }).toList()));
  }
}

class Items {
  String title;
  String img;
  Items({this.title, this.img});
}

class Post {
  String id;
  String name;
  Post({this.id, this.name});
}
