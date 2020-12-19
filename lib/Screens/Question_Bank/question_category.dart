import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/Screens/Home/components/expansiontile.dart';
import 'package:flutter_auth/models/contents.dart';
import 'package:flutter_auth/Screens/Video/video_screen.dart';
import 'package:flutter_auth/Screens/Audio/audio_screen.dart';
import 'package:flutter_auth/Screens/Documents/document_screen.dart';
import 'package:flutter_auth/models/category.dart';
import 'package:flutter_auth/Screens/Notes/notes_screen.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';
import 'package:flutter_auth/components/question.dart';
import 'package:flutter_auth/Screens/Question_Bank/question_bank.dart';

class QuestionCategory extends StatefulWidget {
  List userList;
  List categoryList;
  var isLoading;

  QuestionCategory({
    Key key,
    @required this.userList,
    @required this.categoryList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _QuestionCategoryState createState() => _QuestionCategoryState(userList, categoryList, isLoading);
}

class _QuestionCategoryState extends State<QuestionCategory> {
  List userList;

  List categoryList;

  List<Question> list = List();
  var isLoading = false;

  _QuestionCategoryState(this.userList, this.categoryList, this.isLoading);
  // var list = [
  //   Contents(
  //     category: 'General Knowledge',
  //   ),
  //   Contents(
  //     category: 'Analytical Reasoning',
  //   ),
  //   Contents(
  //     category: 'English',
  //   ),
  //   Contents(
  //     category: 'Mathematics',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightBlue[900],
          title: new Text('Question Bank'),
        ),
        drawer: NavDrawer(userList: userList),
        body: Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: categoryList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                          onTap: () async{
                            print(categoryList[index].name);
                            Map data = {"category": categoryList[index].name};

                            final response = await http.post(
                            "https://oxystech-study-app-nodejs.herokuapp.com/admin/question/ui",body: data,headers: { 'Authorization': 'Bearer '+userList[5]});
                            if (response.statusCode == 200) {
                            list = (json.decode(response.body) as List)
                                .map((data) => new Question.fromJson(data))
                                .toList();
                            print(json.decode(response.body));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionBankScreen(
                                      userList: userList,
                                      questionList: list,
                                      isLoading: isLoading)),
                            );
                            }
                            else {
                              throw Exception('Failed to load questions');
                            }
                          }, child: ListItem(categoryList[index],context));
                    }),
              ),
            )
          ],
        ),
      ),
    ),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }

  Widget ListItem(Category listItem, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          ListTile(
            leading: Icon(Icons.assignment),
            title: Text(listItem.name),
          ),



            ],

          // Text(
          //   listItem.name,
          //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          // ),

      ),

    );
  }

}
