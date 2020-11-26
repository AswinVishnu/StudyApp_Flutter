class Audio {
  final String img;
  final String title;
  final String path;
  final String type;

  Audio({this.img, this.title, this.path, this.type});

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
        img: json['img'], title: json['title'], path: json['path'], type: json['type']);
  }
}
