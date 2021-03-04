class Join_usr_acss {
  String usernames;
  String akses;

  Join_usr_acss({
    this.usernames,
    this.akses,
  });

  factory Join_usr_acss.fromJson(Map<String, dynamic> json) {
    return Join_usr_acss(usernames: json['Username'], akses: json['Akses']);
  }
}
