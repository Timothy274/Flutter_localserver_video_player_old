class usr_acss {
  String id;
  String akses;

  usr_acss({this.akses, this.id});

  factory usr_acss.fromJson(Map<String, dynamic> json) {
    return usr_acss(id: json['ID'], akses: json['Akses']);
  }
}
