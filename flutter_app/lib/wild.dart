import 'package:flutter/material.dart';
import 'farm.dart';

class WildPage extends StatefulWidget {
  @override
  _WildPageState createState() => _WildPageState();
}

class _WildPageState extends State<WildPage> {
  List<String> entries = new List<String>();
  List<String> images = new List<String>();

  @override
  Widget build(BuildContext context) {
    FarmPage.goodbye.forEach((line) {
      var arr = line.toString().split(",");
      if (!entries.contains(arr[0])) entries.add(arr[0]);
      if (!images.contains(arr[0])) images.add(arr[1]);
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Animals Gone Wild"),backgroundColor: Colors.black,),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.amber[100],
              child: Row(
                children: <Widget>[
                  SizedBox(width: 30,),
                  Image.network('${images[index]}'),
                  SizedBox(width: 50,),
                  Text('NAME : ${entries[index]}'),
                ],
              ),
//              Center(child: Text('Entry ${entries[index]}')),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
    );
  }
}