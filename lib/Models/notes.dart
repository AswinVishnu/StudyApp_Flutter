class Notes {
  final String image;
  final String title;
  final String description;
  final String type;
  final String category;
  final String visibility;
  final String status;


  Notes({this.image, this.title,this.description, this.type, this.category, this.visibility, this.status});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        type: json['type'],
        category: json['category'],
        visibility: json['visibility'],
        status: json['status']
    );

  }
}
