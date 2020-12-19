import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Models/exam.dart';
import 'package:flutter_auth/Models/option.dart';
import 'package:flutter_auth/Models/question.dart';
import 'package:flutter_auth/Models/_question.dart';
import 'package:flutter_auth/Screens/Practice_Tests/components/resultpage.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';

class ExamSetup extends StatelessWidget {
  // accept the langname as a parameter
  final List userList;
  bool isLoading;
  String examName;
  Exam exam;
  List<Exam> examList;
  ExamSetup(
      this.examName, this.exam, this.examList, this.isLoading, this.userList);

  @override
  Widget build(BuildContext context) {
    List<Questions> questions = [];

    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      builder: (context, snapshot) {
        if (exam == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          exam.questions.shuffle();
          exam.questions.forEach((var element) {
            Questions q = Questions();
            List<Option> options = [];
            Option optA = Option();
            Option optB = Option();
            Option optC = Option();
            Option optD = Option();
            q.question = element.question;
            q.answer = element.answer;
            optA.answer = element.optionA;
            optA.correct = (optA.answer == q.answer) ? true : false;
            options.add(optA);
            optB.answer = element.optionB;
            optB.correct = (optB.answer == q.answer) ? true : false;
            options.add(optB);
            optC.answer = element.optionC;
            optC.correct = (optC.answer == q.answer) ? true : false;
            options.add(optC);
            optD.answer = element.optionD;
            optD.correct = (optD.answer == q.answer) ? true : false;
            options.add(optD);
            q.options = options;
            questions.add(q);
          });
          print(questions);

          return quizpage(
              examName: examName,
              data: questions,
              examList: examList,
              exam: exam);
        }
      },
    );
  }
}

class quizpage extends StatefulWidget {
  final String examName;
  final List<Questions> data;
  final List<Exam> examList;
  final List userList;
  bool isLoading;
  final Exam exam;

  quizpage(
      {Key key,
      @required this.examName,
      @required this.data,
      @required this.examList,
      @required this.isLoading,
      @required this.userList,
      @required this.exam})
      : super(key: key);
  @override
  _quizpageState createState() =>
      _quizpageState(examName, data, examList, isLoading, userList, exam);
}

class _quizpageState extends State<quizpage> {
  final String examName;
  final List<Questions> data;
  final List<Exam> examList;
  final List userList;
  bool isLoading;
  final Exam exam;
  _quizpageState(this.examName, this.data, this.examList, this.isLoading,
      this.userList, this.exam);

  Color colortoshow = Colors.lightBlue[800];
  Color answered = Colors.lightBlue[900];
  int marks = 0;
  int i = 0;
  bool disableAnswer = false;
  int j = 0;
  int timer;
  String showtimer;
  // int timer = exam.duration;
  // String showtimer = "30";

  Map<String, Color> btncolor = {
    "0": Colors.lightBlue[800],
    "1": Colors.lightBlue[800],
    "2": Colors.lightBlue[800],
    "3": Colors.lightBlue[800],
  };

  bool canceltimer = false;

  @override
  void initState() {
    //timer = (int.parse(exam.duration)) * 60;
    timer = 30 * 60;
    showtimer = "00:00";
    starttimer();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    // String showtimer = exam.duration;
    // int timer = int.parse(showtimer);
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          //nextquestion();
        } else if (timer < 60) {
          String initShowtimer = timer.toString();
          if (initShowtimer.length == 1) {
            showtimer = "0" + showtimer;
          }
          timer = timer - 1;
        } else if (timer < 3600) {
          int m = timer ~/ 60;
          int s = timer - (60 * m);
          String mString = m.toString();
          String sString = s.toString();
          if (mString.length == 1) {
            mString = "0" + mString;
          }
          if (sString.length == 1) {
            sString = "0" + sString;
          }
          showtimer = mString + ":" + sString;
          timer = timer - 1;
        } else if (timer > 3600) {
          int h = timer ~/ 60;
          int t = timer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          String hString = h.toString();
          String mString = m.toString();
          String sString = s.toString();
          if (mString.length == 1) {
            mString = "0" + mString;
          }
          if (sString.length == 1) {
            sString = "0" + sString;
          }
          if (hString.length == 1) {
            hString = "0" + hString;
          }
          showtimer = hString + ":" + mString + ":" + sString;
          timer = timer - 1;
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    setState(() {
      if (i < (data.length - 1)) {
        i = i + 1;
        print('incremented i=' + i.toString());
      } else {
        print('marks: ' + marks.toString());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(
              marks: marks,
              totalMarks: data.length,
              examName: examName,
              examList: examList,
              isLoading: isLoading,
              userList: userList),
        ));
      }
      btncolor["0"] = Colors.lightBlue[800];
      btncolor["1"] = Colors.lightBlue[800];
      btncolor["2"] = Colors.lightBlue[800];
      btncolor["3"] = Colors.lightBlue[800];
      disableAnswer = false;
    });
  }

  void checkanswer(String k) {
    print('checking answer');
    print(data[i].answer);
    print(data[i].options[(int.parse(k))].answer);
    if (data[i].answer == data[i].options[(int.parse(k))].answer) {
      marks = marks + 1;
      print('marks added: ' + marks.toString());
      colortoshow = answered;
    } else {
      colortoshow = answered;
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(Duration(seconds: 2), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          data[i].options[(int.parse(k))].answer,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 18.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.lightBlue[900],
        highlightColor: Colors.lightBlue[1000],
        minWidth: 180.0,
        height: 42.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Quizstart",
                  ),
                  content: Text("You Can't Go Back At This Stage."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Ok',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
          body: (isLoading == true)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Background(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            (i + 1).toString() +
                                " out of " +
                                data.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              fontFamily: "Quando",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(18.0),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Q.  " + data[i].question,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quando",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: AbsorbPointer(
                          absorbing: disableAnswer,
                          child: Container(
                              child: Column(
                            children: <Widget>[
                              RadioListTile(
                                title: const Text('Lafayette'),
                                value: data[i].options[0],
                                groupValue: 'Lafayette',
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Thomas Jefferson'),
                                value: 'Thomas Jefferson',
                                groupValue: 'Thomas Jefferson',
                                onChanged: (value) {
                                  setState(() {
                                    print(value);
                                  });
                                },
                              ),
                            ],
                          )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Center(
                            child: Text(
                              showtimer,
                              style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Times New Roman',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
