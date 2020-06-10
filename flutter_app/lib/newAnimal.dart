import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'farm.dart';

class NewAnimalPage extends StatefulWidget {
  static bool newAnimal = false;
  @override
  _NewAnimalPageState createState() => _NewAnimalPageState();
}

class _NewAnimalPageState extends State<NewAnimalPage> {
  final _nameController = TextEditingController();
  final bird = "https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/bird.png?alt=media&token=0e6e0605-5e5d-48c1-9264-04b7d376e371";
  final cat = "https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/cat.png?alt=media&token=90c7ff0f-164c-45a4-b63b-fc02c8342553";
  final chicken = "https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/chicken.png?alt=media&token=a0934cfe-ab97-41f6-ae78-20bf0753bfbd";
  final dog = "https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/dog.png?alt=media&token=df51264e-535a-4216-a9da-198b7862da59";
  final fish = "https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/clown-fish.png?alt=media&token=1efd02af-bd20-442a-b1ca-9e2edd78142d";
  final cow = "https://firebasestorage.googleapis.com/v0/b/vegan-daily-app-vegimeal.appspot.com/o/cow.png?alt=media&token=52229151-2c68-447f-950a-929fea31c937";
  BuildContext ctx;

  String fileName;


  void showMessage(String msg) {
    final snackbar = SnackBar(content: Text(msg));

    Scaffold.of(ctx)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_upload,
              semanticLabel: 'save',
              color: Colors.black,
            ),
            onPressed: () {
              print(fileName);
              print(_nameController.text);

              if((fileName != null) && (_nameController.text != null)) {
                //wild로 보내고, iamge랑 name 바꾸기//
                String wild = FarmPage.name+","+FarmPage.image;
                if(!FarmPage.goodbye.contains(wild))
                FarmPage.goodbye.add(wild);

                Firestore.instance.collection('farm').document(LoginPage.loginUser)
                    .updateData({
                  'name' : _nameController.text,
                  'image': fileName,
                  'weight': 20,
                  'goodbye': FarmPage.goodbye,
                });

                FarmPage.name = _nameController.text;
                FarmPage.image = fileName;

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
                InkWell(
                  child: Image.network(bird, width: 120, height: 120),
                  onTap: () {
                    setState(() {
                      fileName = bird;
                    });
                  },
                ),
                InkWell(
                  child: Image.network(cat, width: 120, height: 120),
                  onTap: () {
                    setState(() {
                      fileName = cat;
                    });
                  },
                ),
                InkWell(
                  child: Image.network(chicken, width: 120, height: 120),
                  onTap: () {
                    setState(() {
                      fileName = chicken;
                    });
                  },
                ),
                InkWell(
                  child: Image.network(dog, width: 120, height: 120),
                  onTap: () {
                    setState(() {
                      fileName = dog;
                    });
                  },
                ),
                InkWell(
                  child: Image.network(cow, width: 120, height: 120),
                  onTap: () {
                    setState(() {
                      fileName = cow;
                    });
                  },
                ),
                InkWell(
                  child: Image.network(fish, width: 120, height: 120),
                  onTap: () {
                    setState(() {
                      fileName = fish;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 100.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Animal Name',
              ),
            ),
            SizedBox(height: 15.0),

            ButtonBar(
              children: <Widget>[
                // TODO: Add a beveled rectangular border to CANCEL (103)
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    _nameController.clear();
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}