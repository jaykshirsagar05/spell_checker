//This one is main dashboard.
import 'package:flutter/material.dart';
import 'package:spell_check/screens/profile.dart';
import 'package:spell_check/screens/stats.dart';

import 'level_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dashboard> {
  int selectedIndex = 0;
  final widgetOptions = [
    new Profile(),
    new Level(),
    new Stats(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile')),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: Text('Practice')),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), title: Text('stats'))
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: onItemTapped,
        elevation: 0.5,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
