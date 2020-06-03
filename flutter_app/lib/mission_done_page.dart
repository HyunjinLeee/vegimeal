import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_page.dart';

class MissionDonePage extends StatelessWidget {
  final FirebaseUser user;

  MissionDonePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '미션 기록지',
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('recipe').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('No data'),
              );
            }
            return _buildBody(snapshot.data.documents);
          },
        ),
      ),
    );
  }

  Widget _buildBody(List<DocumentSnapshot> documents) {
    final myPosts =
        documents.where((doc) => doc['email'] == user.email).toList();

    return SafeArea(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildGridCards(context, documents[index], documents);
          }),
    );
  }

  Widget _buildGridCards(context, document, List<DocumentSnapshot> snapshot) {
    //final record = Record.fromSnapshot(data);
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailPage(document, user)), //snapshots.data.documents
          );
        },
        child: Image.network(
          document['photoUrl'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
