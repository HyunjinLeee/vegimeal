import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'create_page.dart';
import 'tab_page.dart';
import 'root_page.dart';

class VegimealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vegimeal',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
        ),
        home: RootPage()
    );
  }
}
