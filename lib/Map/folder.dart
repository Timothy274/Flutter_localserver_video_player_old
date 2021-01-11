class Folder {
  String path;
  String name;

  Folder({
    this.path,
    this.name,
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
        path: json['path'],
        name: json['name']
    );
  }
}

