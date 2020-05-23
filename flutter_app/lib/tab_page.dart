import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TabPage extends StatefulWidget {
  final FirebaseUser user;

  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  List _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      //HomePage(widget.user),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        //backgroundColor: Color,
        //selectedItemColor: ,
        //unselectedItemColor: ,
        //iconSize: ,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            title: Text('Animal')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            title: Text('Recipes')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            title: Text('Photos')
          )
        ],
      ),
    );
  }
}

/*
Icon(Icons.border_color)
Icon(Icons.today)
Icon(Icons.event_available)
Icon(Icons.timer)
Icon(Icons.alarm_on)
Icon(Icons.alarm)
Icon(Icons.schedule)
Icon(Icons.photo_library)
Icon(Icons.photo_camera)
Icon(Icons.camera_alt)
Icon(Icons.person)
Icon(Icons.forum)
Icon(Icons.account_circle)
Icon(Icons.account_box)
Icon(Icons.assignment_ind)
Icon(Icons.pets)
Icon(Icons.local_dining)
*/