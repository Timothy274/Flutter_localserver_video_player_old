import 'package:flutter/material.dart';

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
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
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
                  ]),
                )
              ])))
            ],
          ),
        ));
  }
}
