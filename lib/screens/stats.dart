import 'package:flutter/material.dart';
import 'package:spell_check/services/bloc.dart' as bloc;
class Stats extends StatelessWidget {
  //final s = bloc.getScore().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(title: Text('Scores')),
      body: Center(
        child: Column(children: <Widget>[
          Text("Your last game score is "),
        ],)
      ),
    );
  }
}