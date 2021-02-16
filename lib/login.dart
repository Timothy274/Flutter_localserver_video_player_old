import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player_pi/Admin/home.dart';
import 'package:video_player_pi/User/home.dart';
import 'Map/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

void main() => runApp(MaterialApp(home: Login()));

class _LoginState extends State<Login> {
  @override
  bool isLogin = false;
  var userLogin;
  List<DataUser> _datauser = [];
  final username = TextEditingController();
  final password = TextEditingController();

  Future<List<DataUser>> getUser() async {
    final response = await http.get("http://timothy.buzz/video_pi/user_account/user.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        _datauser.add(DataUser.fromJson(Data));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    cek();
  }

  void _showdialogerror() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error Login"),
          content: new Text("Username / Password salah, Mohon lakukan login ulang"),
          actions: <Widget>[
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

  Future cek() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin")) {
      if (pref.getString("username") == "admin") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    }
  }

  void validasi() async {
    String _username = username.text;
    String _password = password.text;
    String susername = "";
    String spassword = "";

    for (int a = 0; a < _datauser.length; a++) {
      if (_datauser[a].username == _username) {
        susername = _username;
      }
      if (_datauser[a].password == _password) {
        spassword = _password;
      }
    }

    if ((susername == "") || (spassword == "")) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isLogin", false);
      _showdialogerror();
    } else if ((susername == "admin") && (spassword == "admin")) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isLogin", true);
      pref.setString("username", susername);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Admin_Home()));
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("isLogin", true);
      pref.setString("username", susername);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(159, 249, 243, 98)),
        child: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
                        child: Image(
                          image: AssetImage(
                            'assets/ic_launcher.png',
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        controller: username,
                        style: TextStyle(color: Color.fromRGBO(11, 189, 180, 1)),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromRGBO(11, 189, 180, 1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromRGBO(11, 189, 180, 1)),
                          ),
                          hintText: "Username",
                          hintStyle: TextStyle(color: Color.fromRGBO(11, 189, 180, 1)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 20.0, right: 20.0),
                      child: TextField(
                        controller: password,
                        style: TextStyle(color: Color.fromRGBO(11, 189, 180, 1)),
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromRGBO(11, 189, 180, 1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color.fromRGBO(11, 189, 180, 1)),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Color.fromRGBO(11, 189, 180, 1)),
                        ),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: new SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Color.fromRGBO(11, 189, 180, 1),
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   new MaterialPageRoute(
                                //       builder: (BuildContext context)=> new MyHomePage()
                                //   )
                                // );
                                validasi();
                              },
                              child: const Text('Sign In', style: TextStyle(fontSize: 30, color: Color.fromRGBO(159, 249, 243, 98))),
                            ))),
                    Divider(
                      height: 10.0,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Text('Sign Up', style: TextStyle(fontSize: 15, color: Color.fromRGBO(11, 189, 180, 1))))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
