import 'package:flutter/material.dart';

class TodayPage extends StatefulWidget {
   static bool bcondition = true;
   static bool lcondition = true;
   static bool dcondition = true;
   static int NumberOfFood = 0;
   static String type;

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  bool fCondition = true;
  bool sCondition = true;
  bool tCondition = true;

  @override
  Widget build(BuildContext context) {
    print("now   "+TodayPage.NumberOfFood.toString());
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 237, 226),
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 240, 237, 226),elevation: 0.0,),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: <Widget>[
              SizedBox(height : 10.0),
              RawMaterialButton(
                onPressed: fCondition ? () {
                  setState(() {
                    sCondition = false;
                    tCondition = false;
                    TodayPage.NumberOfFood = 1;
                  });
                } : null,
                elevation: 2.0,
                fillColor: fCondition ? Colors.white : Colors.grey,
                child: Text("1"), //size 35
                padding: EdgeInsets.all(30.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: sCondition ? () {
                  setState(() {
                    fCondition = false;
                    tCondition = false;
                    TodayPage.NumberOfFood = 2;
                  });
                } : null,
                elevation: 2.0,
                fillColor: sCondition ? Colors.white : Colors.grey,
                child: Text("2"),
                padding: EdgeInsets.all(30.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: tCondition ? () {
                  setState(() {
                    sCondition = false;
                    fCondition = false;
                    TodayPage.NumberOfFood = 3;
                  });
                } : null,
                elevation: 2.0,
                fillColor: tCondition ? Colors.white : Colors.grey,
                child: Text("3"),
                padding: EdgeInsets.all(30.0),
                shape: CircleBorder(),
              ),
              SizedBox(height : 20.0),
              RawMaterialButton(
                onPressed: TodayPage.NumberOfFood > 0 ? () {
                  setState(() {
                      TodayPage.type = "Breakfast";
                      Navigator.pushNamed(context,'/add');
                  });
                } : null,
                elevation: 2.0,
                fillColor: TodayPage.bcondition ? Colors.white : Colors.grey,
                child: Text("Breakfast"),
                padding: EdgeInsets.all(30.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: TodayPage.NumberOfFood > 0 ? () {
                  setState(() {
                    TodayPage.type = "lunch";
                    Navigator.pushNamed(context,'/add');
                  });
                } : null,
                elevation: 2.0,
                fillColor: TodayPage.lcondition ? Colors.white : Colors.grey,
                child: Text("lunch"),
                padding: EdgeInsets.all(30.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: TodayPage.NumberOfFood > 0 ? () {
                  setState(() {
                    TodayPage.type = "Dinner";
                    Navigator.pushNamed(context,'/add');
                  });
                } : null,
                elevation: 2.0,
                fillColor: TodayPage.dcondition ? Colors.white : Colors.grey,
                child: Text("Dinner"),
                padding: EdgeInsets.all(30.0),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

