// This file is used to communicate with firbase services
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spell_check/screens/home.dart' as hm;

Firestore _firestore = Firestore.instance;

final String uid = hm.getUid().toString();
var score;

Future<String> getGrade() async{
  var docref = await _firestore.collection('/users').document(uid).get();
  var grade = docref['grade'];
  return grade;
}

Future getS() async{
  var docref = await _firestore.collection('/users').document(uid).get();
  score = docref['score'];
}
int getScore () {
  getS();
  return score;
}

 Future<void> updateGrade(String s) async {
  final FirebaseUser user =  await FirebaseAuth.instance.currentUser();
  final uid = user.uid.toString();
  print(uid);
  _firestore.collection('/users').document(uid).updateData({
    'grade':s,
  });
}

Future<void> updateScore(int s) async {
    final FirebaseUser user =  await FirebaseAuth.instance.currentUser();
    final uid = user.uid.toString();
    print(uid);
    _firestore.collection('/users').document(uid).updateData({
    'score':s,
  });
  }

