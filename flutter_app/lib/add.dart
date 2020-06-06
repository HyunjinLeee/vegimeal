import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'today.dart';
import 'login.dart';
import 'package:uuid/uuid.dart';
import 'farm.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  File _image;
  String fileName;
  String downloadURL;
  String type;
  List<String> entries = <String>["vegan","Lacto vegetarian","Ovo vegetarian","Lacto-ovo vegetarian","Pesco-vegetarian","Pollo-vegetarian","Flexitarian"];
  List<String> tag = List<String>();

  void getGalleryImage(ImageSource source, {BuildContext context}) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
      fileName = _image.path.split('/').last;

    });
  }

  Future<void> _uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);
    await storageUploadTask.onComplete;
    String url = await storageReference.getDownloadURL();
    setState(() {
      downloadURL = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance.reference().child("recipe");
    tag.add(dbRef.equalTo("foodName").toString());
    // recipe 제목 불러와서 테그에 넣기

    final children = <Widget>[];
    for (var i = 0; i < entries.length; i++) {
      children.add(
          ActionChip(
              backgroundColor: Color.fromARGB(255, 240, 237, 226),
              label: Text('${entries[i]}'),
              onPressed: () {
                if(!tag.contains(entries[i]))
                tag.add(entries[i]);
              }
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add " + TodayPage.type),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_upload,
              semanticLabel: 'save',
              color: Colors.white,
            ),
            onPressed: () {
              //firestore에 이미지; 저장해야 함...
              if(fileName != null) _uploadFile();
              
              if(downloadURL != null) {
                Firestore.instance.collection('food').document(Uuid().v1())
                    .setData({
                  'image': downloadURL,
                  'uid': LoginPage.loginUser,
                  'tag': tag
                });
                Firestore.instance.collection('farm').document(LoginPage.loginUser)
                    .updateData({ 'weight' : FarmPage.weight + 10});

                if (TodayPage.type == "Breakfast") {
                  TodayPage.bcondition = false;
                } else if (TodayPage.type == "lunch") {
                  TodayPage.lcondition = false;
                } else {
                  TodayPage.dcondition = false;
                }
                TodayPage.NumberOfFood--;
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),

      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                _image == null ? Image.asset('image/defualt.png') : Image.file(_image),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.camera_alt,
                semanticLabel: 'profile',
              ),
              onPressed: () {
                getGalleryImage(ImageSource.gallery, context: context);
              },
            ),
            SizedBox(height: 100.0),
            Column(
              children: children,
            )
          ],
        ),
      ),
    );
  }
}