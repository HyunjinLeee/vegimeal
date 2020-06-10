import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'dart:io';
import 'package:mlkit/mlkit.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:async/async.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final DocumentSnapshot document;
  final FirebaseUser user;

  DetailPage(this.document, this.user);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //title: Text(document['foodName']),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Center(
              child: Image.network(
                document['photoUrl'],
                fit: BoxFit.cover,
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Color(0xffA1B5A7),
                thickness: 2,
                //indent: 5,
                //endIndent: 5,
              ),
            ),
            //SizedBox(height: 5),
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: Text(
                  document['foodName'],
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'
                  ),
                ),
                trailing: Text(
                  'Writer: ' + document['displayName'],
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('준비물',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Text(document['ingredient']),
            ),
            SizedBox(
              height: 5
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('만드는 방법',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                document['howTo'],
              ),
            ),
            IconButton(
              icon: Icon(Icons.format_list_numbered),
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LabelImageWidget(document['photoUrl'])),
                );
              },),
          ],
        ),
      ),
    );
  }
}

class LabelImageWidget extends StatefulWidget {
  String imageURL;

  LabelImageWidget(this.imageURL);

  @override
  _LabelImageWidgetState createState() => _LabelImageWidgetState(imageURL);
}

class _LabelImageWidgetState extends State<LabelImageWidget> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  String imageURL;
  File _file;
  List<VisionLabel> _currentLabels = <VisionLabel>[];

  FirebaseVisionLabelDetector detector = FirebaseVisionLabelDetector.instance;

  _LabelImageWidgetState(this.imageURL);

  @override
  initState() {
    super.initState();
    //urlToFile.then((){
    //https://idlecomputer.tistory.com/326
    //});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Image Labeling',
            style: GoogleFonts.getFont(
              'Bellota',
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.black,
            ),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  urlToFile(String imageUrl){
    return this._memoizer.runOnce(() async {
      var rng = new Random();

      Directory tempDir = await getTemporaryDirectory();

      String tempPath = tempDir.path;

      File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');

      http.Response response = await http.get(imageUrl);

      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        _file = file;
      });

      try {
        var currentLabels =
        await detector.detectFromPath(_file?.path);
        setState(() {
          _currentLabels = currentLabels;
        });
      } catch (e) {
        print(e.toString());
      }
    });
  }

  Widget _buildImage() {
    return SizedBox(
      height: 350.0,
      child: Center(
        child: _file == null
            ? Text('No Image')
            : FutureBuilder<Size>(
          future: _getImageSize(Image.file(_file, fit: BoxFit.fitWidth)),
          builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: Image.file(_file, fit: BoxFit.fitWidth));
            } else {
              return Text('Detecting...');
            }
          },
        ),
      ),
    );
  }

  Future<Size> _getImageSize(Image image) {
    Completer<Size> completer = Completer<Size>();
    image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
            (ImageInfo info, bool _) => completer.complete(
            Size(info.image.width.toDouble(), info.image.height.toDouble()))));
    return completer.future;
  }

  Widget _buildBody() {
    urlToFile(imageURL);

    return Container(
      child: Column(
        children: <Widget>[
          _buildImage(),
          _buildList(_currentLabels),
        ],
      ),
    );
  }

  Widget _buildList(List<VisionLabel> labels) {
    if (labels.length == 0) {
      return Text('Empty');
    }
    return Expanded(
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: labels.length,
            itemBuilder: (context, i) {
              return _buildRow(labels[i].label, labels[i].confidence);
            }),
      ),
    );
  }

  Widget _buildRow(String label, double confidence) {
    return ListTile(
      //m--------------------------------------------언니주목!! 라벨이 출력되는 곳------------------------------
      title: Text(
        "${label}:${confidence}",
      ),
      dense: true,
    );
  }
}

