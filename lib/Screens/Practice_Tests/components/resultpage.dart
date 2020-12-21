import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/exam.dart';
import 'package:flutter_auth/Screens/Practice_Tests/practice_tests.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';

class resultpage extends StatefulWidget {
  int marks;
  int totalMarks;
  String examName;
  List<Exam> examList;
  final List userList;
  bool isLoading;

  resultpage(
      {Key key,
      @required this.marks,
      @required this.totalMarks,
      @required this.examName,
      @required this.examList,
      @required this.isLoading,
      @required this.userList})
      : super(key: key);
  @override
  _resultpageState createState() => _resultpageState(
      marks, totalMarks, examName, examList, isLoading, userList);
}

class _resultpageState extends State<resultpage> {
  int marks;
  int totalMarks;
  String examName;
  List<Exam> examList;
  List userList;
  bool isLoading;
  List<String> images = [
    "assets/images/success.gif",
    "assets/images/good.gif",
    "assets/images/bad.gif",
  ];

  String message;
  String image;

  @override
  void initState() {
    print("exam^^^^^page" + userList[1]);
    super.initState();
    initializeDateFormatting();
    int percentage = ((marks / totalMarks) * 100).round();
    print(percentage);
    if (percentage < 60) {
      image = images[2];
      message =
          "You Should Try Hard..\n" + "You Scored $marks out of $totalMarks";
    } else if (percentage < 85) {
      image = images[1];
      message =
          "You Can Do Better..\n" + "You Scored $marks out of $totalMarks";
    } else {
      image = images[0];
      message =
          "You Did Very Well..\n" + "You Scored $marks out of $totalMarks";
    }
    super.initState();
  }

  void sendResult() async {
    print(userList);
    Map data = {
      'userId': userList[0],
      'examName': examName,
      'score': marks.toString() + "/" + totalMarks.toString(),
      'attendedBy': userList[3],
      'attendedOn': DateFormat("dd-MM-yyyy").format(DateTime.now()),
      'instituteId': userList[5],
    };
    print(data);
    final response = await http.post(
        "https://oxystech-study-app-nodejs.herokuapp.com/user/exam/submit",
        body: data);
    if (response.statusCode == 200) {
      print("Result send");
    } else {
      throw Exception("Failed to send result");
    }
  }

  _resultpageState(this.marks, this.totalMarks, this.examName, this.examList,
      this.isLoading, this.userList);
  @override
  Widget build(BuildContext context) {
    sendResult();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Result",
          ),
        ),
        body: (isLoading == true)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Background(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Material(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Material(
                                child: Container(
                                  width: 350.0,
                                  height: 350.0,
                                  child: ClipRect(
                                    child: Image(
                                      image: AssetImage(
                                        image,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 15.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      message,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "Quando",
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OutlineButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => PracticeTestsScreen(
                                    examList: examList,
                                    userList: userList,
                                    isLoading: isLoading),
                              ));
                            },
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 25.0,
                            ),
                            borderSide:
                                BorderSide(width: 3.0, color: Colors.indigo),
                            splashColor: Colors.indigoAccent,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
