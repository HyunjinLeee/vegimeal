import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'newAnimal.dart';

class FarmPage extends StatefulWidget {
  static List<dynamic> goodbye;
  static int weight;
  static String name;
  static String image;
  FarmPage(user);
  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {

  Future<void> _loadInformation() async {

    await Firestore.instance.collection("farm").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if(result.documentID == LoginPage.loginUser){
          result.data.forEach((key,data){
            if(key == "name"){

              FarmPage.name = data.toString();
            }
            if(key == "image"){
              //print(data);
              FarmPage.image = data.toString();
            }
            if(key == "weight"){
              //print(data);
              FarmPage.weight = data;
            }
            if(key == "goodbye"){
              FarmPage.goodbye = data;
            }
          });
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    _loadInformation();

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 139, 106, 79),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.pets),
            color: Color.fromARGB(255, 240, 237, 226),
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
                    padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                    height: 430,
                    child: Stack(
                      children:[
                        CustomPaint(
                          size: Size(double.infinity, double.infinity),
                          painter: CirclePainter(),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 0, top: 0),
                          child: Center(
                            child: Stack(
                              children: <Widget>[
                                NewAnimalPage.newAnimal ? IconButton(
                                  icon: Icon(Icons.pets),
                                  color: Color.fromARGB(255, 240, 237, 226),
                                  onPressed: (){
                                    Navigator.pushNamed(context,'/new');
                                  },
                                )
                                    :
                                FarmPage.image == null?
                                Image.asset('image/defualt.png',width: 1,height: 1,) :
                                Image.network(FarmPage.image, width: (FarmPage.weight.toDouble() *3) ,height: (FarmPage.weight.toDouble() *3),fit:BoxFit.fill ),
                              ],

                            ),
                          )
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    child: (FarmPage.name == null)? Text("Your uid : "+LoginPage.loginUser+"\n\t\tLoding..."):
                    Text(FarmPage.name + "\n"+FarmPage.weight.toString()+"kg",style: GoogleFonts.getFont(
                      'Literata',
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 240, 237, 226),
                    ),),
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
