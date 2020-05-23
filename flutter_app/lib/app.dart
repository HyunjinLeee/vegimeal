import 'package:flutter/material.dart';
import 'login.dart';
import 'tab_page.dart';

class VegimealApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vegimeal',
        home: LoginPage(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
//          '/tabpage': (context) => TabPage(),
        }
    );
  }
}