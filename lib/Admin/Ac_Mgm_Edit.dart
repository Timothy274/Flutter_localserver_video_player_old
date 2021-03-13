import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player_pi/Map/folder_pck.dart';
import 'package:http/http.dart' as http;
import 'package:video_player_pi/Map/test.dart';
import 'package:video_player_pi/Map/user_access.dart';

import 'home.dart';

class Ac_Mgm_Edit_Admin extends StatefulWidget {
  String id, nama, username, email, password;
  Ac_Mgm_Edit_Admin(this.id, this.nama, this.username, this.email, this.password);
  @override
  _Ac_Mgm_Edit_AdminState createState() => _Ac_Mgm_Edit_AdminState();
}

class _Ac_Mgm_Edit_AdminState extends State<Ac_Mgm_Edit_Admin> {
  TextEditingController _controllerNama;
  TextEditingController _controllerUsername;
  TextEditingController _controllerEmail;
  TextEditingController _controllerPassword;

  @override
  void initState() {
    super.initState();
    _controllerNama = new TextEditingController(text: widget.nama);
    _controllerUsername = new TextEditingController(text: widget.username);
    _controllerEmail = new TextEditingController(text: widget.email);
    _controllerPassword = new TextEditingController(text: widget.password);
  }

  void cek() {
    var nama = _controllerNama.text;
    var username = _controllerUsername.text;
    var email = _controllerEmail.text;
    var password = _controllerPassword.text;
    if (nama.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty) {
      dialogerrorisidata();
    } else {
      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Ac_Mgm_Admin_Edit_CheckBox(widget.id)));
    }
  }

  void dialogerrorisidata() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Data yang anda masukkan kurang"),
          content: new Text("Mohon untuk periksa kembali data yang anda masukkan"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(159, 249, 243, 98)),
          child: Stack(
            children: [
              Center(
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: new Text(
                    "Edit User",
                    style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  margin: const EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
                  child: Column(children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment(-1, -1),
                          child: new Text(
                            "Name",
                            style: TextStyle(fontSize: 25.0, fontFamily: 'Poppins'),
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
                          margin: const EdgeInsets.only(top: 30),
                          alignment: Alignment(-1, -1),
                          child: new Text(
                            "Username",
                            style: TextStyle(fontSize: 25.0, fontFamily: 'Poppins'),
                          ),
                        ),
                        TextField(controller: _controllerUsername)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          alignment: Alignment(-1, -1),
                          child: new Text(
                            "Email",
                            style: TextStyle(fontSize: 25.0, fontFamily: 'Poppins'),
                          ),
                        ),
                        TextField(
                          controller: _controllerEmail,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          alignment: Alignment(-1, -1),
                          child: new Text(
                            "Password",
                            style: TextStyle(fontSize: 25.0, fontFamily: 'Poppins'),
                          ),
                        ),
                        TextField(
                          controller: _controllerPassword,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            padding: EdgeInsets.only(bottom: 20, top: 40),
                            child: new RaisedButton(
                                color: Color.fromRGBO(159, 249, 243, 98),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                                onPressed: () {
                                  cek();
                                },
                                textColor: Colors.black,
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Text("Hak Akses".toUpperCase(), style: TextStyle(fontSize: 20)),
                                ))),
                        Container(
                            padding: EdgeInsets.only(bottom: 20, top: 40),
                            child: new RaisedButton(
                                color: Color.fromRGBO(159, 249, 243, 98),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                                onPressed: () {},
                                textColor: Colors.black,
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Text("Update User".toUpperCase(), style: TextStyle(fontSize: 20)),
                                ))),
                      ],
                    )
                  ]),
                )
              ])))
            ],
          ),
        ));
  }
}

class Ac_Mgm_Admin_Edit_CheckBox extends StatefulWidget {
  String id;
  Ac_Mgm_Admin_Edit_CheckBox(this.id);
  @override
  Ac_Mgm_Admin_Edit_CheckBoxState createState() => Ac_Mgm_Admin_Edit_CheckBoxState();
}

class Ac_Mgm_Admin_Edit_CheckBoxState extends State<Ac_Mgm_Admin_Edit_CheckBox> {
  List<Folder_pck> dataFolder = [];
  List<usr_acss> dataAkses = [];
  List dataAkses_Id = List();
  bool value = false;
  List _selectedId = [];
  List<String> check_akses = [];
  List<Test> data_full = [];

  void initState() {
    super.initState();
    datagather();
  }

  Future<List> getDataAkses() async {
    final response = await http.get("http://timothy.buzz/video_pi/user_account/get_user_akses.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        dataAkses.add(usr_acss.fromJson(Data));
      }
      for (int a = 0; a < dataAkses.length; a++) {
        if (widget.id == dataAkses[a].id) {
          dataAkses_Id.add(dataAkses[a].akses);
        }
      }
    });
  }

  Future<List> getData() async {
    final response = await http.get("http://timothy.buzz/video_pi/get_folder.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        dataFolder.add(Folder_pck.fromJson(Data));
      }
    });
  }

  Future<List> datagather() async {
    await Future.wait([getData(), getDataAkses()]);
    setState(() {
      for (int a = 0; a < dataFolder.length; a++) {
        if (dataAkses_Id.contains(dataFolder[a].id)) {
          data_full.add(Test(dataFolder[a].id, dataFolder[a].name, true));
        } else {
          data_full.add(Test(dataFolder[a].id, dataFolder[a].name, false));
        }
      }
    });
    cek_akses();
  }

  void cek_akses() {
    for (int a = 0; a < data_full.length; a++) {
      if (data_full[a].hasil == true) {
        _selectedId.add(data_full[a].id);
      }
    }
  }

  void _onCategorySelected(bool selected, _searchId) {
    if (selected == true) {
      setState(() {
        if (_selectedId.contains(_searchId)) {
        } else {
          _selectedId.add(_searchId);
        }
      });
    } else {
      setState(() {
        if (_selectedId.contains(_searchId)) {
          _selectedId.remove(_searchId);
        }
      });
    }
  }

  void hasil() {
    var url_hapus = "http://timothy.buzz/video_pi/user_account/delete_user_akses.php";
    var url_tambah = "http://timothy.buzz/video_pi/user_account/add_user_akses.php";
    http.post(url_hapus, body: {
      "ID": widget.id,
    });

    for (int a = 0; a < _selectedId.length; a++) {
      http.post(url_tambah, body: {
        "ID": widget.id,
        "Akses": _selectedId[a],
      });
    }
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Admin_Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(159, 249, 243, 98)),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    child: new Text(
                      "New User",
                      style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(20),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            //   physics: BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            itemBuilder: (builder, index) {
                              return new CheckboxListTile(
                                title: Text(
                                  data_full[index].name,
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 20, color: Colors.black),
                                ),
                                value: _selectedId.contains(data_full[index].id),
                                onChanged: (bool selected) {
                                  _onCategorySelected(selected, (data_full[index].id));
                                },
                              );
                            },
                            itemCount: data_full.length)),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(bottom: 20, top: 10),
                      child: new RaisedButton(
                          color: Color.fromRGBO(159, 249, 243, 98),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            hasil();
                          },
                          textColor: Colors.black,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text("Update Akses".toUpperCase(), style: TextStyle(fontSize: 20)),
                          ))),
                ],
              )
            ],
          ),
        ));
  }
}
