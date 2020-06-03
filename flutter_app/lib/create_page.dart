import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePage extends StatefulWidget {
  final FirebaseUser user;

  CreatePage(this.user);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final foodNameController = TextEditingController();
  final ingredientController = TextEditingController();
  final howToController = TextEditingController();

  void dispose() {
    foodNameController.dispose();
    ingredientController.dispose();
    howToController.dispose();
    super.dispose();
  }

  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      //maxHeight: 600,
      //maxWidth: 600,
    );

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            child: Text('Upload'),
            onPressed: () {
              _uploadFile(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5,),
            Center(
              child: MaterialButton(
                child: _showImage(),
                //Text('이미지 선택'),
                onPressed: _getImage,
                //color: Colors.white,
                textColor: Color(0xffa1b5a7),
                elevation: 0,
                height: 150,
                minWidth: 150,
              )
            ),
            SizedBox(height: 4,),
            Divider(
              color: Color(0xffA1B5A7),
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            SizedBox(height: 10,),
            Text(
              '    음식 이름',
            ),
            SizedBox(height: 5,),
            TextField(
              controller: foodNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffdadada),
                focusColor: Colors.black,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                hintText: '음식 이름',
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '    재료',
            ),
            SizedBox(height: 5,),
            //SizedBox(height: 4,),
            TextField(
              controller: ingredientController,
              maxLines: 3,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffdadada),
                focusColor: Colors.black,
                contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                hintText: '재료',
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '    만드는 방법',
            ),
            SizedBox(height: 5,),
            //SizedBox(height: 4,),
            TextField(
              controller: howToController,
              maxLines: 10,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffdadada),
                focusColor: Colors.black,
                contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                hintText: '만드는 방법',
              ),
              //expands: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _showImage() {
    return _image == null
        ? Text('\nSelect Image\n')
        : Image.file(
            _image,
            height: 250,
            width: 250,
            fit: BoxFit.cover,
          );
  }

  Future _uploadFile(BuildContext context) async {
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('recipe')
        .child('${DateTime.now().millisecondsSinceEpoch}.png');

    final task = firebaseStorageRef.putFile(
      _image,
      StorageMetadata(contentType: 'image/png'),
    );

    final storageTaskSnapshot = await task.onComplete;

    final downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    await Firestore.instance.collection('recipe').add({
      'foodName': foodNameController.text,
      'ingredient': ingredientController.text,
      'howTo': howToController.text,
      'displayName': widget.user.displayName,
      'email': widget.user.email,
      'photoUrl': downloadUrl,
      'userPhotoUrl': widget.user.photoUrl,
    });
    Navigator.pop(context);
  }
}
