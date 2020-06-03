import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            Text(
              '   ' + document['foodName'],
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 3,),
            Text(
              '      글쓴이: ' + document['displayName'],
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('     준비물'),
            ListTile(
              leading: Text(document['ingredient']),
            ),
            SizedBox(
              height: 5,
            ),
            Text('    만드는 방법'),
            ListTile(
              leading: Text(
                document['howTo'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
