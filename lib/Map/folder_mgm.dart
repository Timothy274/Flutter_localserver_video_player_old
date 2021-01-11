class inner_folder{
  String path;
  String name;

  inner_folder(
    this.name,
    this.path
  );

  Map toJson() => {
    'name': name,
    'path': path,
  };
}

class folder_mgm{
  String fldr_name;
  String path;
  inner_folder contain;

  folder_mgm(
    this.fldr_name, 
    this.path, 
    [this.contain]
  );

  Map <String, dynamic> toJson() => {
    'fldr_name' : fldr_name,
    'path' : path,
    'contain' : contain,
  };
}

