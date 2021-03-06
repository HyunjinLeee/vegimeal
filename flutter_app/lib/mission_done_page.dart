import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DonePage extends StatefulWidget {
  final FirebaseUser user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  DonePage(this.user);

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  List<Card> _buildGridCards(BuildContext context, List<DocumentSnapshot> snapshot) {

    return snapshot.map((data) {//snapshot data
      final record = Record.fromSnapshot(data);

      final children = <Widget>[];
      for (var i = 0; i < record.tag.length; i++) {
        if(record.tag[i].toString().startsWith("Instance")) continue;
        children.add(
            Chip(
              backgroundColor: Color.fromARGB(255, 139, 106, 79),
              label: Text('${record.tag[i]}', style: TextStyle(fontSize: 15, fontWeight : FontWeight.bold, color: Color.fromARGB(255, 240, 237, 226))),
            )
        );
      }

      return Card(
        clipBehavior: Clip.antiAlias,
        color: Color.fromARGB(255, 240, 237, 226),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: FutureBuilder(
                future: _getImage(context,record.s_image),
                builder: (context, snapshot) {
                  return Container(
                    child: snapshot.data,
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: ListView(
//                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("food").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) { print(snapshot.error.toString()); }
        return _buildList(context, snapshot.data.documents);
      },
    );
  }


  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      physics: ScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 9.0,
      children: _buildGridCards(context, snapshot),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Builder(builder: (BuildContext context){
            return FlatButton(
              child: Text('Sign out'),
              textColor: Colors.grey,
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                //_googleSignIn.signOut();
              },
            );
          },)
        ],
      ),
      body: Column(
        children: <Widget>[
          //SizedBox(height: 8),
          Expanded(
            child:_buildBody(context),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<Widget> _getImage(BuildContext context, String image) async {
    if(image.startsWith("http")) return Image.network(image);
    final StorageReference ref = FirebaseStorage.instance.ref().child(image);
    String url = await ref.getDownloadURL() as String;
    Image m = Image.network(url);

    return m;
  }

}


class Record {
  String s_image;
  List<dynamic> tag;

  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      :
        assert(map['image'] != null),
        s_image = map['image'],
        tag = map['tag'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}