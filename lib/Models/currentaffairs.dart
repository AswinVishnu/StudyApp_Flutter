class CurrentAffairs {
  final String image;
  final String title;
  final String description;
  final String status;
  final String date;

  CurrentAffairs({this.image, this.title,this.description, this.status,this.date});

  factory CurrentAffairs.fromJson(Map<String, dynamic> json) {
    return CurrentAffairs(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        status: json['status'],
        date: json['date']
    );

  }
}
