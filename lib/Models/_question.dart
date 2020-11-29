import 'package:flutter_auth/Models/option.dart';

class Questions {
  String question;
  String answer;
  String previousSelected;
  List<Option> options;

  Questions({this.options, this.previousSelected, this.question, this.answer});
}
