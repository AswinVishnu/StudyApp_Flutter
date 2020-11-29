class Question {
  final String id;
  final String question;
  final String answer;
  final String content;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final bool status;

  Question._(
      {this.content,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD,
      this.status,
      this.id,
      this.question,
      this.answer});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question._(
        id: json['id'],
        question: json['question'],
        content: json['content'],
        optionA: json['optionA'],
        optionB: json['optionB'],
        optionC: json['optionC'],
        optionD: json['optionD'],
        status: json['status'],
        answer: json['answer']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'content': content,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'status': status,
    };
  }
}
