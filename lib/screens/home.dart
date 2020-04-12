import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spell_check/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String uid;
  String getUid(){
    return uid;
  }

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[],
        elevation: 0.0,
        title: Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (BuildContext context, AsyncSnapshot user) {
                if (user.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  uid = user.data.uid;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome!!! ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {
              Navigator.of(context).pushReplacementNamed('/dashboard');
            },
            tooltip: "Next",),
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