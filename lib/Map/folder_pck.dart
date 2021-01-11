class Folder_pck {
  String id;
  String name;
  String path;

  Folder_pck({
    this.id,
    this.name,
    this.path
  });

  factory Folder_pck.fromJson(Map<String, dynamic> json) {
    return Folder_pck(
        id: json['ID_Folder'],
        path: json['Path_Folder'],
        name: json['Name_Folder']
    );
  }
}