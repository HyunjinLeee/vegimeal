import 'package:flutter/material.dart';
import 'login.dart';
import 'wild.dart';
import 'add.dart';
import 'root_page.dart';
import 'newAnimal.dart';
import 'mission_done_page.dart';

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
          '/wild': (context) => WildPage(),
          '/add' : (context) => AddPage(),
          '/new' : (context) => NewAnimalPage(),
//          '/photo' : (context) => DonePage(),
        }
    );
  }
}
