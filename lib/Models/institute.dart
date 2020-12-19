class Institute {
  final String id;
  final String accountName;


  Institute({this.id, this.accountName});

  factory Institute.fromJson(Map<String, dynamic> json) {
    return Institute(
        id: json['id'],
        accountName: json['accountName'],
        );

  }
}
