class Contents {
  final String image;
  final String title;
  final String url;
  final String description;
  final String type;
  final String category;


  Contents({this.image, this.title, this.url,this.description, this.type, this.category});

  factory Contents.fromJson(Map<String, dynamic> json) {
    return Contents(
        image: json['image'],
        title: json['title'],
        url: json['url'],
        description: json['description'],
        type: json['type'],
        category: json['category']);

  }
}
