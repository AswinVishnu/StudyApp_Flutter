class Video {
  final String img;
  final String title;
  final String url;
  final String type;

  Video({this.img, this.title, this.url, this.type});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        img: json['img'], title: json['title'], url: json['url'], type: json['type']);
  }
}
