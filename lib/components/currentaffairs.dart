class CurrentAffairs {
  final String img;
  final String title;
  final String description;
  final String date;

  CurrentAffairs({this.img, this.title, this.description, this.date});

  factory CurrentAffairs.fromJson(Map<String, dynamic> json) {
    return CurrentAffairs(
        img: json['img'], title: json['title'], description: json['description'], date: json['date']);
  }
}
