class Performance {
  final String examName;
  final String attendedOn;
  final String attendedBy;
  final String score;



  Performance({this.examName, this.attendedOn, this.attendedBy,this.score});

  factory Performance.fromJson(Map<String, dynamic> json) {
    return Performance(
        examName: json['examName'],
        attendedOn: json['attendedOn'],
        attendedBy: json['attendedBy'],
        score: json['score']);

  }
}
