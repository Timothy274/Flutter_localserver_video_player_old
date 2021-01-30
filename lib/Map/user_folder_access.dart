class User_access {
  String id;
  String akses;

  User_access({this.id, this.akses});

  factory User_access.fromJson(Map<String, dynamic> json) {
    return User_access(id: json['ID'], akses: json['Akses']);
  }
}
