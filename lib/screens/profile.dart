import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spell_check/main.dart';
//import 'package:spell_check/screens/level.dart';
import 'package:spell_check/services/bloc.dart' as bloc;
import 'package:spell_check/services/repository.dart' as repository;

//import 'main.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //Level level = new Level();
  String dropdownValue = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   actions: <Widget>[],
      //   elevation: 0.0,
      //   title: Text("Dashboard"),
      // ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (BuildContext context, AsyncSnapshot user) {
                if (user.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        user.data.displayName.toString() + "!  ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                          "Select your grade-",
                          style: TextStyle(
                          color: Colors.grey,
                          // fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        iconEnabledColor: Colors.blue[200],
                        elevation: 10,
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                        onChanged: (String newnum){
                          setState(() async {
                            dropdownValue = newnum;
                            // Fluttertoast.showToast(
                            //     msg: "Grade updated",
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.BOTTOM,
                            //     timeInSecForIosWeb: 1,
                            //     backgroundColor: Colors.blueAccent,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0
                            // );
                            // try{
                            //   await Firestore.instance.collection('/users').document(user.data.uid).updateData({'grade': dropdownValue});
                            // }catch(e){
                            //   Fluttertoast.showToast(
                            //     msg: "Try after sometime",
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.BOTTOM,
                            //     timeInSecForIosWeb: 1,
                            //     backgroundColor: Colors.blueAccent,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0
                            // );
                            repository.updateGrade(newnum);
                            
                           // Navigator.of(context).pushReplacementNamed('/dashboard');
                          });
                        },
                        items: <String> ['1','2','3','4','5']
                          .map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList() ,
                      )
                    ],
                  );
                }
              },
            ),
            // IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {
            //   //new Dashboard();
            //   Navigator.of(context).pushReplacementNamed('/dashboard');
            // },
            // tooltip: "Next",),
            FlatButton(
              splashColor: Colors.white,
              highlightColor: Theme.of(context).hintColor,
              child: Text(
                "Logout",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                auth.signOut().then((onValue) {
                  Navigator.of(context).pushReplacementNamed('/login');
                });
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
    }
}



  