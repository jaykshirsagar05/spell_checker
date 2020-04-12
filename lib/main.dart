import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spell_check/screens/game_screen.dart';
import 'package:spell_check/screens/level_screen.dart';
import 'package:spell_check/screens/home.dart';
import 'package:spell_check/screens/login-register.dart';
import 'package:spell_check/screens/dashbord.dart';
import 'package:spell_check/screens/stats.dart';

void main() {
  
    runApp(new MyApp());
  
}

final FirebaseAuth auth = FirebaseAuth.instance;


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Spell_check',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Color(0xFFC0F0E8),
          primaryColor: Color(0xFF80E1D1),
          fontFamily: "Montserrat",
          canvasColor: Colors.transparent),
      home: new StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          }
          return LoginRegister();
        },
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(),
        '/login': (BuildContext context) => new LoginRegister(),
        '/dashboard': (BuildContext context) => new Dashboard(),
        '/practice': (BuildContext context) => new Level(),
        '/game': (BuildContext context) => new Game(),
        '/stats': (BuildContext context) => new Stats(),
      },
    );
  }
}