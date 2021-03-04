import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player_pi/Admin/Folder_Mgm_Add.dart';
import 'package:video_player_pi/Admin/Folder_Mgm_Edit.dart';
import 'package:video_player_pi/Map/folder_pck.dart';
import 'package:http/http.dart' as http;

class Folder_Mgm_Admin extends StatefulWidget {
  @override
  _Folder_Mgm_AdminState createState() => _Folder_Mgm_AdminState();
}

class _Folder_Mgm_AdminState extends State<Folder_Mgm_Admin> {
  List<Folder_pck> dataFolder = [];

  void initState() {
    super.initState();
    getData();
  }

  Future<List<Folder_pck>> getData() async {
    final response = await http.get("http://timothy.buzz/video_pi/get_folder.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        dataFolder.add(Folder_pck.fromJson(Data));
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
                    "Folder Manage",
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        itemBuilder: (builder, index) {
                          return new GestureDetector(
                              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Folder_Mgm__Edit_Admin(dataFolder[index].id, dataFolder[index].name, dataFolder[index].path))),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          dataFolder[index].name,
                                          style: TextStyle(fontFamily: 'Poppins', fontSize: 20, color: Colors.white),
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
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Folder_Mgm_Add_Admin()));
        },
        backgroundColor: Color.fromRGBO(11, 189, 180, 1),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
