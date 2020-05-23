import 'package:flutter/material.dart';
import 'login.dart';

class VegimealApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vegimeal',
        home: LoginPage(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
        }
    );
  }
}