import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player_pi/Map/folder_pck.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Ac_Mgm_Edit_Admin extends StatefulWidget {
  String id, nama, username, email, password;
  Ac_Mgm_Edit_Admin(
      this.id, this.nama, this.username, this.email, this.password);
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
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) =>
              new Ac_Mgm_Admin_Add_CheckBox(nama, username, email, password)));
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
          content:
              new Text("Mohon untuk periksa kembali data yang anda masukkan"),
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
        resizeToAvoidBottomPadding: false,
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
                  margin:
                      const EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
                  child: Column(children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment(-1, -1),
                          child: new Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'Poppins'),
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
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'Poppins'),
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
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'Poppins'),
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
                            style: TextStyle(
                                fontSize: 25.0, fontFamily: 'Poppins'),
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
                                  child: Text("Hak Akses".toUpperCase(),
                                      style: TextStyle(fontSize: 20)),
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
                                  child: Text("Update User".toUpperCase(),
                                      style: TextStyle(fontSize: 20)),
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

class Ac_Mgm_Admin_Add_CheckBox extends StatefulWidget {
  String nama, username, email, password;
  Ac_Mgm_Admin_Add_CheckBox(
      this.nama, this.username, this.email, this.password);
  @override
  _Ac_Mgm_Admin_Add_CheckBoxState createState() =>
      _Ac_Mgm_Admin_Add_CheckBoxState();
}

class _Ac_Mgm_Admin_Add_CheckBoxState extends State<Ac_Mgm_Admin_Add_CheckBox> {
  List<Folder_pck> dataFolder = [];
  List _selectedId = List();

  void initState() {
    super.initState();
    getData();
  }

  Future<List> getData() async {
    final response =
        await http.get("http://timothy.buzz/video_pi/get_folder.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        dataFolder.add(Folder_pck.fromJson(Data));
      }
    });
  }

  void cek() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new Admin_Home()));
  }

  void _onCategorySelected(bool selected, _searchId) {
    if (selected == true) {
      setState(() {
        _selectedId.add(_searchId);
      });
    } else {
      setState(() {
        _selectedId.remove(_searchId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemBuilder: (builder, index) {
                            return new GestureDetector(
                                onTap: () {},
                                child: LimitedBox(
                                    maxHeight: 100,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: new BoxDecoration(
                                              color: Color.fromRGBO(
                                                  11, 189, 180, 1),
                                              borderRadius:
                                                  new BorderRadius.all(
                                                const Radius.circular(10.0),
                                              )),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Text(
                                                  dataFolder[index].name,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Checkbox(
                                            value: _selectedId
                                                .contains(dataFolder[index].id),
                                            onChanged: (bool selected) {
                                              _onCategorySelected(selected,
                                                  (dataFolder[index].id));
                                            },
                                          ),
                                          alignment: Alignment.centerRight,
                                        ),
                                      ],
                                    )));
                          },
                          itemCount: dataFolder.length),
                    ),
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
                          onPressed: () {},
                          textColor: Colors.black,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Text("Update Akses".toUpperCase(),
                                style: TextStyle(fontSize: 20)),
                          ))),
                ],
              )
            ],
          ),
        ));
  }
}
