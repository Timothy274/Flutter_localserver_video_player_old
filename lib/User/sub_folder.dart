import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:video_player_pi/User/preview.dart';
import 'package:video_player_pi/User/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Map/folder.dart';

class Sub_Folder extends StatefulWidget {
  @override
  String path;
  String name;

  Sub_Folder({this.path, this.name});

  _Sub_FolderState createState() => _Sub_FolderState();
}

class _Sub_FolderState extends State<Sub_Folder> {
  int _counter = 0;
  String _result = '';
  List<Folder> datavideo = [];
  List filter_datavideo = [];
  TextEditingController controller = new TextEditingController();
  String filter;
  List<Folder> _filtered = [];
  List<Folder> _null_filtered = [];

  void _incrementCounter() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  void _alterfilter(String query) {
    List<Folder> dummySearchList = [];
    dummySearchList.addAll(_filtered);
    if (query.isNotEmpty) {
      List<Folder> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _filtered.clear();
        _filtered.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _filtered.clear();
        _filtered.addAll(_null_filtered);
      });
    }
  }

  void initState() {
    super.initState();
    getData();
  }

  void pass(path) {
    String Name = path.toString().toLowerCase();
    print(Name);
    if (Name.endsWith('.mp4') || Name.endsWith('.mkv')) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new Player(
                path: path,
              )));
    }
  }

  Future<List<Folder>> getData() async {
    final response = await http.get("http://192.168.0.200/access/server_1/scan.php");
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map Data in responseJson) {
        datavideo.add(Folder.fromJson(Data));
      }
      for (int a = 0; a < datavideo.length; a++) {
        if (datavideo[a].path.contains(widget.path)) {
          var substr_folder_initiative = datavideo[a].path.toString().lastIndexOf('/');
          var name_folder_initiative = (datavideo[a].path.toString().substring(0, substr_folder_initiative));
          // print(name_folder_initiative);
          if (filter_datavideo.contains(name_folder_initiative)) {
          } else {
            if (name_folder_initiative == widget.path) {
              filter_datavideo.add(datavideo[a].path);
            } else {
              filter_datavideo.add(name_folder_initiative);
            }
          }
        }
      }
    });
    for (int a = 0; a < filter_datavideo.length; a++) {
      var substr_folder = filter_datavideo[a].toString().lastIndexOf('/');
      String name_folder = (filter_datavideo[a].toString().substring(substr_folder + 1));
      _null_filtered.add(Folder(name: name_folder, path: filter_datavideo[a]));
      _filtered.add(Folder(name: name_folder, path: filter_datavideo[a]));
    }
    // for (int a = 0; a < filter_datavideo.length; a++) {
    //   print(filter_datavideo);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: Color.fromRGBO(11, 189, 180, 1), style: BorderStyle.solid)),
                        child: TextField(
                          decoration:
                              InputDecoration(hintText: 'Search your videos', contentPadding: EdgeInsets.all(15), border: InputBorder.none),
                          controller: controller,
                          onChanged: (value) {
                            _alterfilter(value);
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 50),
                    //   child: GestureDetector(
                    //     onTap: (){ _alterfilter();},
                    //     child: Icon(
                    //       Icons.search_rounded,
                    //       color: Color.fromRGBO(11, 189, 180, 1),
                    //       size: 40,
                    //     )
                    //   )
                    // )
                  ],
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
                              onTap: () {
                                pass(_filtered[index].path);
                              },
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
                                          _filtered[index].name,
                                          style: TextStyle(fontFamily: 'BalsamiqSans_Blod', fontSize: 20, color: Colors.white),
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
                        itemCount: _filtered.length),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
