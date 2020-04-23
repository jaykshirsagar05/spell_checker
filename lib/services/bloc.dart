import 'package:cloud_firestore/cloud_firestore.dart';
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

// int getScore() {
//    return repository.getScore();
// }

String currentLevel;
List currentAsset;

void setLevel(String s){
  currentLevel = s;
}

String getLevel(){
  return currentLevel;
}

void setAsset(List l){
  print(l);
  currentAsset = l;
}

List getAsset(){
  return currentAsset;
}

List totalWords = [];

Future setTotalWords() async {
  for (var s in currentAsset) {
    var word =
        await Firestore.instance.collection('/words').document('grade_1').get();
        var l = word[s.toString()];
        for(var a in l) {
          totalWords.add(a);
        }
        //totalWords.add(s);
  }
}
 List getTotalWords(){
   return totalWords;
 }

 void removeTotalWords(){
   totalWords.clear();
 }

void makeUserdir(){
  repository.makeUserdir();
}

void updateScore(int s){
  var level = getLevel();
  repository.updateScore(level, s);
}

void addToSkipped(String s){
  var level = getLevel();
  repository.addToSkipped(level,s);
}