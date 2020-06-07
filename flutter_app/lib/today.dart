import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayPage extends StatefulWidget {
  static bool bcondition = true;
  static bool lcondition = true;
  static bool dcondition = true;
  static int NumberOfFood = 0;
  static String type;

  TodayPage(user);
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  bool fCondition = true;
  bool sCondition = true;
  bool tCondition = true;

  @override
  Widget build(BuildContext context) {
    print("now   " + TodayPage.NumberOfFood.toString());
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF6F4EC),

        body: SingleChildScrollView(
          //padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              Text(
                'Select your missions',
                style: GoogleFonts.getFont(
                  //'Oleo Script Swash Caps',
                  //'Fredoka One',
                  'Oleo Script',
                  fontWeight: FontWeight.w900,
                  fontSize: 42,
                  color: Color(0xff6a756d),
                  textStyle: TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.black26
                      )
                    ]
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Text(
                'How many meals a day did you eat as a vegiterian?',
                textAlign: TextAlign.left,
                style: GoogleFonts.getFont(
                  'Pacifico',
                  //'Dancing Script',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffbdbdbd),
              ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: fCondition
                        ? () {
                            setState(() {
                              sCondition = false;
                              tCondition = false;
                              TodayPage.NumberOfFood = 1;
                            });
                          }
                        : null,
                    elevation: 5.0,
                    fillColor: fCondition ? Colors.white : Colors.grey,
                    child: Text(
                      "1",
                      style: GoogleFonts.getFont(
                        'Literata',
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    padding: EdgeInsets.all(30.0),
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: sCondition
                        ? () {
                            setState(() {
                              fCondition = false;
                              tCondition = false;
                              TodayPage.NumberOfFood = 2;
                            });
                          }
                        : null,
                    elevation: 5.0,
                    fillColor: sCondition ? Colors.white : Colors.grey,
                    child: Text(
                      "2",
                      style: GoogleFonts.getFont(
                        'Literata',
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    padding: EdgeInsets.all(30.0),
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: tCondition
                        ? () {
                            setState(() {
                              sCondition = false;
                              fCondition = false;
                              TodayPage.NumberOfFood = 3;
                            });
                          }
                        : null,
                    elevation: 5.0,
                    fillColor: tCondition ? Colors.white : Colors.grey,
                    child: Text(
                      "3",
                      style: GoogleFonts.getFont(
                        'Literata',
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    padding: EdgeInsets.all(30.0),
                    shape: CircleBorder(),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              Text(
                'When did you eat as a vegiterian?',
                textAlign: TextAlign.left,
                style: GoogleFonts.getFont(
                  'Pacifico',
                  //'Dancing Script',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffbdbdbd)
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: TodayPage.NumberOfFood > 0
                        ? () {
                            setState(() {
                              TodayPage.type = "Breakfast";
                              Navigator.pushNamed(context, '/add');
                            });
                          }
                        : null,
                    elevation: 5.0,
                    fillColor:
                        TodayPage.bcondition ? Colors.white : Colors.grey,
                    child: Text(
                      "Breakfast",
                      style: GoogleFonts.getFont(
                        'Literata',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    padding: EdgeInsets.all(32.0),
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: TodayPage.NumberOfFood > 0
                        ? () {
                            setState(() {
                              TodayPage.type = "Lunch";
                              Navigator.pushNamed(context, '/add');
                            });
                          }
                        : null,
                    elevation: 5.0,
                    fillColor:
                        TodayPage.lcondition ? Colors.white : Colors.grey,
                    child: Text(
                      "Lunch",
                      style: GoogleFonts.getFont(
                        'Literata',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    padding: EdgeInsets.all(32.0),
                    shape: CircleBorder(),
                  ),
                  RawMaterialButton(
                    onPressed: TodayPage.NumberOfFood > 0
                        ? () {
                            setState(() {
                              TodayPage.type = "Dinner";
                              Navigator.pushNamed(context, '/add');
                            });
                          }
                        : null,
                    elevation: 5.0,
                    fillColor:
                        TodayPage.dcondition ? Colors.white : Colors.grey,
                    child: Text(
                      "Dinner",
                      style: GoogleFonts.getFont(
                        'Literata',
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    padding: EdgeInsets.all(32.0),
                    shape: CircleBorder(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
