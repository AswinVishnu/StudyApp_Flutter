class Audio {
  final String image;
  final String title;
  final String url;
  final String type;

  Audio({this.image, this.title, this.url, this.type});

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
        image: json['image'],
        title: json['title'],
        url: json['url'],
        type: json['type']);
  }
}
