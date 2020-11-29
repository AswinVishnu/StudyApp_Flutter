class Category {
  final String name;

  Category({this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(

        name: json['name']);

  }
}
