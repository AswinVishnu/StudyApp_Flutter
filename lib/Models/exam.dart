import 'package:flutter_auth/models/question.dart';

class Exam {
  final String id;
  final String name;
  final String batch;
  final String examDate;
  final String startTime;
  final String endTime;
  final String description;
  final List<Question> questions;
  final bool status;
  final String duration;
  final String duration_ui;

  Exam._(
      {this.name,
      this.batch,
      this.examDate,
      this.startTime,
      this.endTime,
      this.status,
      this.id,
      this.questions,
      this.description,
      this.duration,
      this.duration_ui});

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam._(
        id: json['id'],
        name: json['name'],
        batch: json['batch'],
        examDate: json['examDate'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        questions: (json['questions'] as List)
            .map((data) => new Question.fromJson(data))
            .toList(),
        status: json['status'],
        description: json['description'],
        duration: json['duration'],
        duration_ui: json['duration_ui']);
  }
}
