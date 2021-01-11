import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player_pi/Admin/Ac_Mgm_Add.dart';
import 'package:video_player_pi/Admin/Ac_Mgm_Edit.dart';
import 'package:video_player_pi/Map/user.dart';
import 'package:http/http.dart' as http;

class Ac_Mgm_Admin extends StatefulWidget {
  @override
  _Ac_Mgm_AdminState createState() => _Ac_Mgm_AdminState();
}

class _Ac_Mgm_AdminState extends State<Ac_Mgm_Admin> {
  List<DataUser> dataFolder = [];

  void initState() {
    super.initState();
    getData();
  }

  Future<List<DataUser>> getData() async {
    final response = await http.get("http://timothy.buzz/video_pi/user.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        dataFolder.add(DataUser.fromJson(Data));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(159, 249, 243, 98)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: new Text(
                    "User Manage",
                    style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins'),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        //   physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        itemBuilder: (builder, index) {
                          return new GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Ac_Mgm_Edit_Admin(
                                              dataFolder[index].id_user,
                                              dataFolder[index].nama,
                                              dataFolder[index].username,
                                              dataFolder[index].email,
                                              dataFolder[index].password))),
                              child: LimitedBox(
                                maxHeight: 150,
                                child: Container(
                                  decoration: new BoxDecoration(
                                      color: Color.fromRGBO(11, 189, 180, 1),
                                      borderRadius: new BorderRadius.all(
                                        const Radius.circular(10.0),
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          dataFolder[index].nama,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(10),
                                      //   child: Stack(
                                      //   alignment: FractionalOffset.bottomRight +
                                      //       const FractionalOffset(-0.1, -0.1),
                                      //   children: <Widget>[
                                      //   ]),
                                      // )
                                    ],
                                  ),
                                ),
                              ));
                        },
                        separatorBuilder: (builder, index) {
                          return Divider(
                            height: 10,
                            thickness: 0,
                          );
                        },
                        itemCount: dataFolder.length),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Ac_Mgm_Admin_Add()));
        },
        backgroundColor: Color.fromRGBO(11, 189, 180, 1),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
