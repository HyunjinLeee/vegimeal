import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tab_page.dart';
import 'recipe_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  static String loginUser;

  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: const Text('Sign out'),
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final FirebaseUser user = await _auth.currentUser();
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                _signOut();
                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _GoogleSignInSection(),
          ],
        );
      }),
    );
  }

  // Example code for sign out.
  void _signOut() async {
    LoginPage.loginUser = null;

    await _auth.signOut();
  }
}


class _GoogleSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleSignInSectionState();
}

class _GoogleSignInSectionState extends State<_GoogleSignInSection> {
  String _userID;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: const Text('Test sign in with Google'),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.center,
          child: RaisedButton(
            onPressed: () async {

              _signInWithGoogle();
//              Navigator.pushNamed(context,'/today'); //////////////
              //Navigator.pushNamed(context,'/tabpage'); //////////////
              /*
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipePage()), //snapshots.data.documents
              );
               */
              /*
              StreamBuilder(
                stream: FirebaseAuth.instance.onAuthStateChanged,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return TabPage(snapshot.data);
                },
              );
              */
            },
            child: const Text('Sign in with Google'),
          ),
        ),
      ],
    );
  }

  // Example code of how to sign in with google.
  void _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _userID = user.uid;
        setState(() {
          LoginPage.loginUser = user.uid;
        });
        Firestore.instance.collection('farm').document(_userID).get().then((docSnapshot) => {
            if (!docSnapshot.exists) {
              //유저가 처음일 경우
              //원래는 새로운 이름 입력받고 해야함,,,
            Firestore.instance.collection('farm').document(_userID).setData({ 'goodbye': [], 'name': "고", "weight":10, "image" : "https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/cat.png?alt=media&token=90c7ff0f-164c-45a4-b63b-fc02c8342553"})
            }
        });
      }
    });
  }
}