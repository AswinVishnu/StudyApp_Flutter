class InstituteDetails {
  final String id;
  final String accountName;
  final String address;
  final String email;
  final String mobile;
  final String image;

  InstituteDetails({this.id, this.accountName, this.address, this.email, this.mobile, this.image});

  factory InstituteDetails.fromJson(Map<String, dynamic> json) {
    return InstituteDetails(
      id: json['id'],
      accountName: json['accountName'],
      address: json['address'],
      email: json['email'],
      mobile: json['mobile'],
      image: json['image'],
    );

  }
}
