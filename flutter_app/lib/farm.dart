import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class FarmPage extends StatefulWidget {
  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  String name;
  String image;
  int weight;
  
  @override
  Widget build(BuildContext context) {
//    Firestore.instance.collection("farm").getDocuments().then((querySnapshot) {
//      querySnapshot.documents.forEach((result) {
//        print("ㅗㅑㅗㅑㅗㅑㅗ");
//        print(result.data);
//      });
//    });

    Firestore.instance
        .collection('farm')
        .document(LoginPage.loginUser)
        .snapshots()
        .listen((DocumentSnapshot ds){
      print("ㅗㅑㅗㅑㅗㅑㅗ");
      print(ds.data);
      print("ㅗㅑㅗㅑㅗㅑㅗ");
      print(LoginPage.loginUser);
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 106, 79),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.pets),
          onPressed: (){
            //////////////////////
          },
        ),
        backgroundColor: Color.fromARGB(255, 139, 106, 79),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
              height: 500,
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: CirclePainter(),
              ),
            ),
            Container(
              height: 50,
              child: Text("돼돌이\n 34kg"),
            ),
          ]
        )
      )
    );
  }
}

class CirclePainter extends CustomPainter {
  var wavePaint = Paint()
    ..color = Color.fromARGB(255, 240, 237, 226)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 9.0
    ..isAntiAlias = true;

  var inPaint = Paint()
    ..color = Color.fromARGB(255, 148, 168, 154)
    ..style = PaintingStyle.fill
    ..strokeWidth = 9.0
    ..isAntiAlias = true;

//  icon = Icons.
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;

    canvas.drawCircle(Offset(centerX, centerY), 170.0, inPaint);
    canvas.drawCircle(Offset(centerX, centerY), 170.0, wavePaint);
  }
  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return false;
  }
}