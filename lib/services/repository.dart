// This file is used to communicate with firbase services
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spell_check/screens/home.dart' as hm;

Firestore _firestore = Firestore.instance;

final String uid = hm.getUid().toString();
var score;

Future<String> getGrade() async{
  var docref = await _firestore.collection('/users').document(uid).get();
  var grade = docref['grade'];
  return grade;
}

// Future getS() async{
//   var docref = await _firestore.collection('/users').document(uid).get();
//   score = docref['score'];
// }
// int getScore () {
//   getS();
//   return score;
// }

 Future<void> updateGrade(String s) async {
  print(uid);
  _firestore.collection('/users').document(uid).updateData({
    'grade':s,
  });
}

  Future<void> updateScore(String l,int s) async {
    var lev = 'level_'+l;
    var data = {lev:s};
    _firestore.collection('/users').document(uid).collection('practice').document('score').updateData(data);
  }

  Future addToSkipped(String l, String s) async {
    var lev = 'level_'+l + "unattempted";
    var data = {lev:s};
    _firestore.collection('/users').document(uid).collection('practice').document('wordsRecord').updateData(data);

  }

  Future makeUserdir() async {
    _firestore.collection('/users').document(uid).collection('practice').document('score').setData({
      'level_1':'0'
    });

    _firestore.collection('/users').document(uid).collection('practice').document('wordsRecord').setData({
      'level_1_attempted':'0'
    });

    _firestore.collection('/users').document(uid).collection('practice').document('userList').setData({
      'mylist_1':[]
    });

  }

