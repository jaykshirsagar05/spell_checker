import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spell_check/services/repository.dart' as repository;

Future<String> getGrade(){
  return repository.getGrade();
}

void updateGrade(String grade) async{
  await repository.updateGrade(grade).then((value){
    Fluttertoast.showToast(
      msg: "Grade updated",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0
  );
  }).timeout(Duration(seconds: 3), onTimeout: (){
    Fluttertoast.showToast(
      msg: "Try after sometime",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0
  );
  });
}

void updateScore(int s) async {
  await repository.updateScore(s);
}

int getScore() {
   return repository.getScore();
}

