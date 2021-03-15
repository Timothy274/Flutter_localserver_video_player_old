import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:video_player_pi/Map/folder_pck.dart';
import 'package:video_player_pi/Map/join_usr_akses.dart';
import 'package:video_player_pi/Map/user_access.dart';
import 'package:video_player_pi/User/profile.dart';
import 'package:video_player_pi/User/sub_folder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Map/folder.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Folder> datavideo = [];
  List<Folder> sub_foldervideo = [];
  List<Join_usr_acss> dataAkses = [];
  List<String> dataAkses_Id = [];
  List<Folder> _filtered = [];
  List<Folder_pck> dataFolder = [];
  List<String> dataFolderPil = [];
  Icon _searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
    size: 30,
  );
  Widget _appBarTitle = new Text('Pi Play');

  String filter;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController controller = new TextEditingController();

  Future<List> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    final response = await http.get("http://timothy.buzz/video_pi/user_account/join_user_akses.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        dataAkses.add(Join_usr_acss.fromJson(Data));
      }
      for (int a = 0; a < dataAkses.length; a++) {
        if (username == dataAkses[a].usernames) {
          dataAkses_Id.add(dataAkses[a].akses);
        }
      }
    });
  }

  Future<List> getDataFolder() async {
    final response = await http.get("http://timothy.buzz/video_pi/get_folder.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        dataFolder.add(Folder_pck.fromJson(Data));
      }
    });
  }

  Future<List> datagather() async {
    await Future.wait([getUser(), getDataFolder()]);
    setState(() {
      for (int a = 0; a < dataFolder.length; a++) {
        if (dataAkses_Id.contains(dataFolder[a].id)) {
          dataFolderPil.add(dataFolder[a].path);
        }
      }
    });
  }

  void _alterfilter(String query) {
    List<Folder> dummySearchList = List<Folder>();
    dummySearchList.addAll(sub_foldervideo);
    if (query.isNotEmpty) {
      List<Folder> dummyListData = List<Folder>();
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
        _filtered.addAll(sub_foldervideo);
      });
    }
  }

  void initState() {
    super.initState();
    datagather();
    getData();
  }

  void folder_management() {
    List<String> filter = List<String>();
    List filter_alter;
    var path_folder;
    var name_folder;

    for (int a = 0; a < datavideo.length; a++) {
      var path_folder = datavideo[a].path.lastIndexOf('/');
      var folder_sub = datavideo[a].path.substring(0, path_folder);
      filter.add(folder_sub);
    }
    filter_alter = filter.toSet().toList();
    for (int a = 0; a < filter_alter.length; a++) {
      path_folder = (filter_alter[a]);
      if (dataFolderPil.contains(path_folder)) {
        var substr_folder = filter_alter[a].toString().lastIndexOf('/');
        name_folder = (filter_alter[a].toString().substring(substr_folder + 1));
        sub_foldervideo.add(Folder(name: name_folder, path: path_folder));
      }
    }
    _filtered.clear();
    _filtered.addAll(sub_foldervideo);
  }

  Future<List<Folder>> getData() async {
    final response = await http.get("http://192.168.0.200/access/server_1/scan.php");
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map Data in responseJson) {
        datavideo.add(Folder.fromJson(Data));
      }
    });
    folder_management();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    if (mounted)
      setState(() {
        getData();
      });
    _refreshController.refreshCompleted();
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
        this._appBarTitle = new Text('Pi Play');
        controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: scaffoldKey,
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
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Profile()));
                  }),
              IconButton(
                  icon: Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Profile()));
                  })
            ],
          ),
          body: Center(
              child: Expanded(
            child: Container(
                margin: const EdgeInsets.all(20),
                child: SmartRefresher(
                  enablePullUp: true,
                  header: ClassicHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //   physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      itemBuilder: (builder, index) {
                        return new GestureDetector(
                            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) => new Sub_Folder(
                                      path: _filtered[index].path,
                                      name: _filtered[index].name,
                                    ))),
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
                )),
          )),
        ));
  }
}
