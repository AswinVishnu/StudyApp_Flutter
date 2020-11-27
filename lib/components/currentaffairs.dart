class CurrentAffairs {
  final String image;
  final String title;
  final String description;
  final String date;

  CurrentAffairs({this.image, this.title, this.description, this.date});

  factory CurrentAffairs.fromJson(Map<String, dynamic> json) {
    return CurrentAffairs(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        date: json['date']);
  }
}
