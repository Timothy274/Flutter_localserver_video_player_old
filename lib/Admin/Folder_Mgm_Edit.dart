import 'package:flutter/material.dart';

class Folder_Mgm__Edit_Admin extends StatefulWidget {
  String id, name_folder,path_folder;
  Folder_Mgm__Edit_Admin(this.id,this.name_folder,this.path_folder);
  @override
  _Folder_Mgm__Edit_AdminState createState() => _Folder_Mgm__Edit_AdminState();
}

class _Folder_Mgm__Edit_AdminState extends State<Folder_Mgm__Edit_Admin> {
  TextEditingController _controllerNama;
  TextEditingController _controllerPath;

  void initState(){
    super.initState();
    _controllerNama = new TextEditingController(text: widget.name_folder);
    _controllerPath = new TextEditingController(text: widget.path_folder);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(159, 249, 243, 98)
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children:<Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(bottom: 20, top: 20),
                      child: new Text("Folder Manage",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'Poppins'
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      margin: const EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
                      child: Column(
                        children:[
                          Column(
                            children: [
                              Container(
                                alignment: Alignment(-1, -1),
                                child: new Text("Name",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Poppins'
                                  ),
                                ),
                              ),  
                              TextField(
                                controller: _controllerNama,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment(-1, -1),
                                child: new Text("Path",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Poppins'
                                  ),
                                ),
                              ),  
                              TextField(
                                controller: _controllerPath
                              )
                            ],
                          ),
                        ]
                      ),
                    )
                  ]
                )
              )
            )
          ],
        ),
      )
    );
  }
}