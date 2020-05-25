import 'package:flutter/material.dart';
import 'farm.dart';

class WildPage extends StatefulWidget {
  @override
  _WildPageState createState() => _WildPageState();
}

class _WildPageState extends State<WildPage> {
  List<String> entries;
  List<String> images;

  @override
  Widget build(BuildContext context) {
    print(FarmPage.goodbye);


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Animals Gone Wild"),backgroundColor: Colors.black,),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.amber,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 30,),
                  Image.network("https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/chicken.png?alt=media&token=a0934cfe-ab97-41f6-ae78-20bf0753bfbd"),
                  SizedBox(width: 50,),
                  Text('Entry ${entries[index]}'),
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