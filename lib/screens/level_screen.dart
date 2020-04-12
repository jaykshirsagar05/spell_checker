import 'package:flutter/material.dart';
//import 'package:spell_check/screens/level.dart';
class Level extends StatefulWidget {
  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Level"),
      // ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget> [
            FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/game');
            },
            child: Text(
            "Level 1",
            style: TextStyle(fontSize: 20.0),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/game');
            },
            child: Text(
            "Level 2",
            style: TextStyle(fontSize: 20.0),
            ),
          ),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/game');
            },
            child: Text(
            "Level 3",
            style: TextStyle(fontSize: 20.0),
            ),
          )
        ]
        )
      ),
    );
  }
}