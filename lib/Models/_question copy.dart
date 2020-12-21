import 'package:flutter_auth/Models/option.dart';

class Questions {
  String question;
  String answer;
  String previousSelected;
  String currentSelected;
  List<Option> options;

  Questions(
      {this.options,
      this.previousSelected,
      this.currentSelected,
      this.question,
      this.answer});
}
