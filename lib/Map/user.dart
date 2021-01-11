class DataUser {
  String id_user;
  String username;
  String nama;
  String password;
  String email;

  DataUser({
    this.id_user,
    this.nama,
    this.username,
    this.password,
    this.email,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      id_user: json['ID'],
      nama: json['Nama'],
      username: json['Username'],
      password: json['Password'],
      email: json['Email']
    );
  }
}