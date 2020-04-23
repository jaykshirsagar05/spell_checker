import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spell_check/services/bloc.dart' as bloc;
class Level extends StatefulWidget {
  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  List press_flags = [false,false,false];
  var Assets = [];

  void _onchanged(int i){
    setState(() {
      if(press_flags[i]==false){
        press_flags[i]=true;
        //Assets.add('level_'+(i+1).toString());
      }
      else{
        press_flags[i]=false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget> [
            Text("Select Assets"),
            FlatButton(
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            onPressed: () {
              _onchanged(0);
              bloc.setLevel("1");
              //Assets.add('level_1');
              //Navigator.of(context).pushReplacementNamed('/game');
            },
            color: press_flags[0]?Colors.blue:Colors.grey,
            child: Text(
            "Level 1",
            style: TextStyle(fontSize: 20.0),
            ),
          ),
          FlatButton(
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              _onchanged(1);
              bloc.setLevel("2");
              //Assets.add('level_2');
              //Navigator.of(context).pushReplacementNamed('/game');
            },
            color: press_flags[1]?Colors.blue:Colors.grey,
            child: Text(
            "Level 2",
            style: TextStyle(fontSize: 20.0),
            ),
          ),
          FlatButton(
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              _onchanged(2);
              bloc.setLevel("3");
              //Assets.add('level_3');
              //Navigator.of(context).pushReplacementNamed('/game');
            },
            color: press_flags[2]?Colors.blue:Colors.grey,
            child: Text(
            "Level 3",
            style: TextStyle(fontSize: 20.0),
            ),
          ),
          RaisedButton(onPressed: (){
            for(int i=0;i<3;i++){
              if(press_flags[i]==true){
                Assets.add("level_"+(i+1).toString());
              }
            }
            if((Assets.length)>0){
              bloc.setAsset(Assets);
            Navigator.of(context).pushReplacementNamed('/game');
            }
            else{
              Fluttertoast.showToast(msg: 'Select atleast one');
            }
            
          },child: Text("Start"))
        ]
        )
      ),
    );
  }
}