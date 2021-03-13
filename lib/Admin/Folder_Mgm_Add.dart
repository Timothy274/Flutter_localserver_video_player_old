import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player_pi/Admin/Folder_Mgm.dart';

class Folder_Mgm_Add_Admin extends StatefulWidget {
  @override
  _Folder_Mgm_Add_AdminState createState() => _Folder_Mgm_Add_AdminState();
}

class _Folder_Mgm_Add_AdminState extends State<Folder_Mgm_Add_Admin> {
  TextEditingController _controllerNama = new TextEditingController();
  TextEditingController _controllerPath = new TextEditingController();

  void cek() {
    var nama = _controllerNama.text;
    var path = _controllerPath.text;
    if (nama == "" || path == "") {
      _showDialogerror();
    } else {
      pass(nama, path);
    }
  }

  void _showDialogerror() {
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

  void pass(nama, path) {
    var url = "http://timothy.buzz/video_pi/add_folder.php";
    http.post(url, body: {
      "Name": nama,
      "Path": path,
    });
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Folder_Mgm_Admin()));
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
              Center(
                  child: SingleChildScrollView(
                      child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: new Text(
                    "Add Folder",
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
                            "Path",
                            style: TextStyle(fontSize: 25.0, fontFamily: 'Poppins'),
                          ),
                        ),
                        TextField(controller: _controllerPath)
                      ],
                    ),
                  ]),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
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
                          child: Text("Add Folder".toUpperCase(), style: TextStyle(fontSize: 20)),
                        ))),
              ])))
            ],
          ),
        ));
  }
}
