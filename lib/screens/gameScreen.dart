import 'package:flutter/material.dart';

class SpellCheck extends StatefulWidget {
  @override
  _SpellCheckState createState() => _SpellCheckState();
}

class _SpellCheckState extends State<SpellCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Level")),
      body: Center(
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
                TextField(
                  // // decoration: InputDecoration(
                  // //   border: InputBorder.none,
                  // //   hintText: "Enter answer",
                  // //   fillColor: Colors.blue,
                  // ),
                ),
                IconButton(icon: Icon(Icons.hearing), onPressed: null),
            ]
          )
        ],)
      ),
    );
  }
}