import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'create_page.dart';
import 'tab_page.dart';
import 'farm.dart';
import 'wild.dart';
import 'today.dart';
import 'add.dart';
import 'root_page.dart';
import 'detail_page.dart';

class VegimealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vegimeal',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
        ),
        home: RootPage(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
//          '/tabpage': (context) => TabPage(),
//          '/farm': (context) => FarmPage(),
          '/wild': (context) => WildPage(),
//          '/today': (context) => TodayPage(),
          '/add' : (context) => AddPage(),
        }
    );
  }
}
