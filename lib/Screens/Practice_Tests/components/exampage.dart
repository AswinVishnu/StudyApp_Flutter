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
              isLoading: isLoading,
              userList: userList,
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
  List userList;
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
  String selected;

  // int timer = exam.duration;
  // String showtimer = "30";

  bool canceltimer = false;

  @override
  void initState() {
    timer = (int.parse(exam.duration_ui)) * 60;
    //timer = 10 * 60;
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
          Widget okButton = FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => resultpage(
                    marks: marks,
                    totalMarks: data.length,
                    examName: examName,
                    examList: examList,
                    isLoading: isLoading,
                    userList: userList),
              ));
            },
          );

          // set up the AlertDialog
          AlertDialog alert = AlertDialog(
            title: Text("Time is up!!!"),
            content: Text("Time is over please click on OK to proceed"),
            actions: [
              okButton,
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
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

  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Submit"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(
              marks: marks,
              totalMarks: data.length,
              examName: examName,
              examList: examList,
              isLoading: isLoading,
              userList: userList),
        ));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text(
          "You have answered all the questions, please click on submit to proceed."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void nextquestion() {
    canceltimer = false;
    setState(() {
      if (i < (data.length - 1)) {
        i = i + 1;
        print('incremented i=' + i.toString());
      } else {
        print('marks: ' + marks.toString());
        showAlertDialog();
      }
      disableAnswer = false;
    });
  }

  void prevquestion() {
    canceltimer = false;
    setState(() {
      if (i != 0) {
        i = i - 1;
        print('descrese i=' + i.toString());
      }

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
      canceltimer = true;
      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(Duration(seconds: 2), nextquestion);
  }

  void checkoption(String option) {
    print('checking answer');
    print(option);
    if (data[i].previousSelected != option) {
      if (data[i].answer == option) {
        marks = marks + 1;
        print('marks added: ' + marks.toString());
      } else if (data[i].previousSelected == data[i].answer) {
        marks = marks - 1;
        print('marks minus: ' + marks.toString());
      } else {
        colortoshow = answered;
      }
    }
    data[i].previousSelected = option;
    setState(() {
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
                      SizedBox(height: 20.0),
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
                        child: SingleChildScrollView(
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
                      ),
                      Expanded(
                        flex: 5,
                        child: AbsorbPointer(
                          absorbing: disableAnswer,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  RadioListTile(
                                    title: Text(data[i].options[0].answer),
                                    value: data[i].options[0].answer,
                                    groupValue: data[i].currentSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        data[i].currentSelected = value;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text(data[i].options[1].answer),
                                    value: data[i].options[1].answer,
                                    groupValue: data[i].currentSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        data[i].currentSelected = value;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text(data[i].options[2].answer),
                                    value: data[i].options[2].answer,
                                    groupValue: data[i].currentSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        data[i].currentSelected = value;
                                      });
                                    },
                                  ),
                                  RadioListTile(
                                    title: Text(data[i].options[3].answer),
                                    value: data[i].options[3].answer,
                                    groupValue: data[i].currentSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        data[i].currentSelected = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: new Row(
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                  child: new Row(
                                    children: <Widget>[
                                      Icon(Icons.arrow_back_rounded,
                                          color: Colors.white, size: 25),
                                      SizedBox(width: 5),
                                      Text(
                                        "Prev",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Alike",
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Timer(Duration(seconds: 2), prevquestion);
                                  },
                                  color: Colors.lightBlue[800],
                                  splashColor: Colors.lightBlue[900],
                                  highlightColor: Colors.lightBlue[1000],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                ),
                              ),
                              Spacer(),
                              ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                  child: new Row(
                                    children: <Widget>[
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Alike",
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.arrow_forward_rounded,
                                          color: Colors.white, size: 25),
                                    ],
                                  ),
                                  onPressed: () =>
                                      checkoption(data[i].currentSelected),
                                  color: Colors.lightBlue[800],
                                  splashColor: Colors.lightBlue[900],
                                  highlightColor: Colors.lightBlue[1000],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                ),
                              )
                            ],
                          ),
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
