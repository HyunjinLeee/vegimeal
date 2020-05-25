import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class FarmPage extends StatefulWidget {
  static List<String> goodbye;
  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  String name;
  String image;
  int weight;
  
  @override
  Widget build(BuildContext context) {
    Firestore.instance.collection("farm").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if(result.documentID == LoginPage.loginUser){
          print(result.data);
          result.data.forEach((key,data){
            if(key == "name"){
              name = data;
            }
            if(key == "image"){
              image = data;
            }
            if(key == "weight"){
              weight = data;
            }
            if(key == "goodbye"){
              FarmPage.goodbye = data;
            }
          });
        }
      });
    });
//    _uploadFile();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 139, 106, 79),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.pets),
          onPressed: (){
            Navigator.pushNamed(context,'/wild');
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
              child: Stack(
                children:[
                  CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: CirclePainter(),
                  ),
                  Image.network(image),
                ],
              ),
            ),
            Container(
              height: 50,
              child: Text(name + "\n"+weight.toString()+"kg"),
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