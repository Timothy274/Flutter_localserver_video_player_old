import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:video_player_pi/User/preview.dart';
import 'package:video_player_pi/User/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Map/folder.dart';

class inherits_sub extends StatefulWidget {
  @override
  String path;

  inherits_sub({this.path});
  _inherits_subState createState() => _inherits_subState();
}

class _inherits_subState extends State<inherits_sub> {
  int _counter = 0;
  String _result = '';
  List<Folder> datavideo = [];
  List filter_datavideo = [];
  TextEditingController controller = new TextEditingController();
  String filter;
  List<Folder> _filtered = [];
  List<Folder> _null_filtered = [];
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
    size: 30,
  );
  Widget _appBarTitle = new Text('Folder');

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
        var name = item.name.toLowerCase();
        if (name.contains(query.toLowerCase())) {
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
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new Player(
              path: path,
            )));
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: controller,
          decoration: new InputDecoration(prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
          onChanged: (value) {
            _alterfilter(value);
          },
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Folder');
        controller.clear();
      }
    });
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
          appBar: AppBar(
            leading: Image(image: AssetImage('assets/Pi_Play.png')),
            title: _appBarTitle,
            backgroundColor: Color.fromRGBO(11, 189, 180, 1),
            actions: [
              IconButton(
                  icon: _searchIcon,
                  onPressed: () {
                    _searchPressed();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.dashboard,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {}),
            ],
          ),
          body: Center(
              child: Column(
            children: [
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
                              // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Preview_Video()));
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
          )),
        ));
  }
}
