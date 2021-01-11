import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:video_player_pi/User/profile.dart';
import 'package:video_player_pi/User/sub_folder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Map/folder.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _result = '';
  List<Folder> datavideo = [];
  List<Folder> sub_foldervideo = [];
  TextEditingController controller = new TextEditingController();
  String filter;
  List<Folder> _filtered = List<Folder>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  void _alterfilter(String query){
    List<Folder> dummySearchList = List<Folder>();
    dummySearchList.addAll(sub_foldervideo);
    if(query.isNotEmpty) {
      List<Folder> dummyListData = List<Folder>();
      dummySearchList.forEach((item) {
        if(item.name.contains(query)) {
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

  void initState(){
    super.initState();
    getData();
  }

  void folder_management(){
    List<String> filter = List<String>();
    List filter_alter;
    var path_folder;
    var name_folder;

    for(int a = 0; a < datavideo.length;a++){
      var path_folder = datavideo[a].path.lastIndexOf('/');
      var folder_sub = datavideo[a].path.substring(0,path_folder);
      filter.add(folder_sub);
    }
    filter_alter = filter.toSet().toList();
    for(int a = 0; a < filter_alter.length;a++){
      path_folder = (filter_alter[a]);
      var substr_folder = filter_alter[a].toString().lastIndexOf('/');
      name_folder = (filter_alter[a].toString().substring(substr_folder + 1));
      sub_foldervideo.add(Folder(name: name_folder,path: path_folder));
      print(path_folder);
    }
    _filtered.clear();
    _filtered.addAll(sub_foldervideo);
  }

  Future<List<Folder>> getData() async {
    try {
      final response = await http.get("http://192.168.0.200/access/scan.php");
      final responseJson = json.decode(response.body);
        setState(() {
        for (Map Data in responseJson) {
          datavideo.add(Folder.fromJson(Data));
        }
      });
      // if(_filtered == null){
      //   _filtered.addAll(datavideo);
      // } else {
      //   for(int a = 0;a < datavideo.length;a++){
      //     if(_filtered.contains(datavideo[a].name)){
            
      //     } else {
      //       // _filtered.removeAt(index)
      //     }
      //   }
      //   _filtered.clear();
      //   _filtered.addAll(datavideo);
      // }
      folder_management();
    } catch (e) {
      print(e.toString());
      _showSnackBar(e.toString());
      return null;
    }
    // for(int a = 0; a < datavideo.length;a++){
    //   print(datavideo[a].name);
    // }
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    if(mounted)
    setState(() { 
      getData(); 
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1, color: Color.fromRGBO(11, 189, 180, 1), style: BorderStyle.solid)),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search your videos',
                            contentPadding: EdgeInsets.all(15),
                            border: InputBorder.none),
                        controller: controller,
                        onChanged: (value){
                          _alterfilter(value);
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context)=> new Profile()
                          )
                        );
                      },
                      child: Icon(
                        Icons.account_circle_rounded,
                        color: Color.fromRGBO(11, 189, 180, 1),
                        size: 40,
                      )
                    )
                  )
                ],
              ),
              Expanded(
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
                            onTap: ()=>Navigator.of(context).push(
                                new MaterialPageRoute(
                                    builder: (BuildContext context)=> new Sub_Folder(path: _filtered[index].path,)
                                )
                            ),
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
                                      style: TextStyle(
                                          fontFamily: 'BalsamiqSans_Blod',
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
                          )
                        );
                      },
                      separatorBuilder: (builder, index) {
                        return Divider(
                          height: 10,
                          thickness: 0,
                        );
                      },
                      itemCount: _filtered.length),
                    )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  _showSnackBar(var text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }
}