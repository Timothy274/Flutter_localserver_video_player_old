import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player_pi/Admin/Ac_Mgm.dart';
import 'package:video_player_pi/Admin/Folder_Mgm.dart';

class Admin_Home extends StatefulWidget {
  @override
  _Admin_HomeState createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(159, 249, 243, 98),
        alignment: Alignment(0, 0),
        child: SingleChildScrollView(
          child: Column(
            children:<Widget>[
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: new Text("Admin Control",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Poppins'
                      ),
                    ),
                    alignment: AlignmentDirectional.topCenter
                  )
                ],
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
                    },
                    child: const Text(
                      'Account Request',
                      style: TextStyle(fontSize: 20,fontFamily: 'Poppins')
                    ),
                  )
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
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context)=> new Ac_Mgm_Admin()
                          )
                        );
                      },
                      child: const Text(
                        'Account Management',
                        style: TextStyle(fontSize: 20,fontFamily: 'Poppins')
                      ),
                    )
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
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context)=> new Folder_Mgm_Admin()
                          )
                        );
                      },
                      child: const Text(
                        'Folder Management',
                        style: TextStyle(fontSize: 20,fontFamily: 'Poppins')
                      ),
                    )
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
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(fontSize: 20,fontFamily: 'Poppins')
                      ),
                    )
                  )
                ),
            ]
          ),
        )
      )
    );
  }
}