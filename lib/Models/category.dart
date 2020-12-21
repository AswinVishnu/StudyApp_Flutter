class Category {
  final String name;
  final String instituteId;

  Category({this.name,this.instituteId});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(

        name: json['name'],
        instituteId: json['instituteId']
    );

  }
}
