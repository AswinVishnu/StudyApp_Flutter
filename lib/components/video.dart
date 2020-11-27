class Video {
  final String image;
  final String title;
  final String url;
  final String type;

  Video({this.image, this.title, this.url, this.type});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        image: json['image'],
        title: json['title'],
        url: json['url'],
        type: json['type']);
  }
}
