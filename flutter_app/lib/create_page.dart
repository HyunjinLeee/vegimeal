import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'textrec.dart';

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
  File _recipeimage;
  var text = '';

  Future _getRecipeImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      //maxHeight: 600,
      //maxWidth: 600,
    );

    setState(() {
      _recipeimage = image;
    });
  }

  Future readText() async {
    FirebaseVisionImage recipeimage = FirebaseVisionImage.fromFile(_recipeimage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(recipeimage);

    for(TextBlock block in readText.blocks) {
      for(TextLine line in block.lines) {
        for(TextElement word in line.elements) {
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    recognizeText.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '레시피 등록',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Center(
                  child: MaterialButton(
                child: _showImage(),
                onPressed: _getImage,
                textColor: Color(0xffa1b5a7),
                elevation: 0,
                height: 150,
                minWidth: 150,
              )),
              SizedBox(height: 5),
              Divider(
                color: Color(0xffA1B5A7),
                thickness: 2,
                //indent: 5,
                //endIndent: 5,
              ),
              SizedBox(height: 5),
              TextField(
                controller: foodNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffe6e6e6),
                  focusColor: Colors.black,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: '음식 이름',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: ingredientController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffe6e6e6),
                  focusColor: Colors.black,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: '재료',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    elevation: 3,
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) =>
                          VisionTextWidget()
                        )
                      );
                      // ML kit
                      /*
                      _getRecipeImage();
                      //readText();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecipeImageWidget(_recipeimage)),
                      );
                       */


                      /*
                      ingredientController.text = text;
                      print(text);
                      print(ingredientController);
                       */

                    },
                    child: Text(
                      '영수증에서 재료 목록 가져오기',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    height: 30,
                    color: Color(0xffbecfc3),
                    textColor: Color(0xff606a6e),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              SizedBox(height: 2),
              TextField(
                controller: howToController,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffe6e6e6),
                  focusColor: Colors.black,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: '만드는 방법',
                ),
                //expands: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showImage() {
    return _image == null
        ? Column(
            children: <Widget>[
              Icon(Icons.find_in_page),
              Text(
                '\nSelect Image\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
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


class RecipeImageWidget extends StatelessWidget {
  //final String text;
  final File image;
  RecipeImageWidget(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          Image(image: FileImage(image),
          height: 300,
          width: 300,),
          //Text('$text'),
      ],)
    );
  }
}

/*
class RecipeImageWidget extends StatelessWidget {
  /*
  final File recipeImage;
  RecipeImageWidget(this.recipeImage);


   */

final String text;
RecipeImageWidget(this.text);

  @override
  _RecipeImageWidgetState createState() => _RecipeImageWidgetState();
}

 */
/*
class _RecipeImageWidgetState extends State<RecipeImageWidget> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('${text}'),
    );
  }

 */
  /*
  String text;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          print(word.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(pickedImage),
              )
            ),
          ),
          RaisedButton(
            child: Text('Image'),
            onPressed: pickImage,
          ),
          RaisedButton(
            child: Text('change'),
            onPressed: readText,
          )
        ],
      ),
    );
  }
}
   */

