import 'package:flutter/material.dart';

class Preview_Video extends StatefulWidget {
  @override
  _Preview_VideoState createState() => _Preview_VideoState();
}

class _Preview_VideoState extends State<Preview_Video> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          new Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
              bottomLeft: const Radius.circular(25.0),
              bottomRight: const Radius.circular(25.0),
            )),
            padding: const EdgeInsets.only(top: 70, bottom: 50, left: 20, right: 20),
          )
        ],
      ),
    );
  }
}
