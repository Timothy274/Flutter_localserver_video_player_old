import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player_pi/login.dart';
import '../Map/user.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferences prefs;
  String nama = "";
  String email = "";
  String password = "";
  String id = "";
  List<DataUser> _datauser = [];

  Future cekuser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("username")!= null){
      setState(() {
        nama = pref.getString("username");
      });
    }
  }

  void initState(){
    super.initState();
    cekuser();
    getUser();
  }

  Future<List<DataUser>> getUser() async {
    final response = await http.get("http://timothy.buzz/juljol/get_user.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        _datauser.add(DataUser.fromJson(Data));
      }
      for (int a = 0;a < _datauser.length;a++){
        if(_datauser[a].username == nama){
            email = _datauser[a].email;
            password = _datauser[a].password;
            id = _datauser[a].id_user;
          }
        }
    });
  }

  Future exit() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
      builder: (BuildContext context)=> new Login()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              children:<Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 24,
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                        exit();
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(fontSize: 30)
                      ),
                    )
                  )
                ),
              ]
            )
          )
        ),
      )
    );
  }
}