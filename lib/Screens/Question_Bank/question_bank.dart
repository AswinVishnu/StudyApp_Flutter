import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class QuestionBankScreen extends StatefulWidget {
  final List userList;
  var isLoading;
  final List questionList;

  QuestionBankScreen({
    Key key,
    @required this.userList,
    @required this.questionList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _QuestionBankState createState() =>
      _QuestionBankState(userList, questionList, isLoading);
}

class _QuestionBankState extends State<QuestionBankScreen> {
  List userList;
  var isLoading;
  List questionList;
  _QuestionBankState(this.userList, this.questionList, this.isLoading);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Question bank'),
        ),
        drawer: NavDrawer(userList: userList),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: questionList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text("Q. " + questionList[index].question),
                    subtitle: Text("Ans. " + questionList[index].answer),
                  );
                }));
  }
}
