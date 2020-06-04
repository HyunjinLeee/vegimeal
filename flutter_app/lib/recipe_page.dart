import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_page.dart';
import 'detail_page.dart';

class RecipePage extends StatelessWidget {
  final FirebaseUser user;

  RecipePage(this.user);

  @override
  Widget build(BuildContext context) {
    final TextStyle display1 = Theme.of(context).textTheme.headline;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '모두의 레시피',
          //style: GoogleFonts.getFont('Bellota', textStyle: display1),
          //style: TextStyle(
          //  fontFamily: 'BlackHanSans',
          //fontStyle: FontStyle.normal,
          //),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.border_color,
              semanticLabel: 'create',
            ),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CreatePage(user)));
            },
          )
        ],
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
    return SafeArea(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
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
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18 / 11,
                child: Image.network(
                  document['photoUrl'],
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 4.0),
                      Text(
                        document['foodName'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        document['displayName'],
                        style: TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}