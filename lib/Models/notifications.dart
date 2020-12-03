class Notifications {
  final String title;
  final String description;
  Notifications({this.title, this.description});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(title: json['title'], description: json['description']);
  }
}