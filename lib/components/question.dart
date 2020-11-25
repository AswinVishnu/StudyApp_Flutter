class Question {
  final String id;
  final String question;
  final String answer;

  Question._({this.id, this.question, this.answer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question._(
        id: json['id'], question: json['question'], answer: json['answer']);
  }
}
