import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'AjouterVoiture.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AllPersonData(),
    );
  }
}

class DemoUploadImage extends StatefulWidget {
  @override
  _DemoUploadImage createState() => _DemoUploadImage();
}

class _DemoUploadImage extends State<DemoUploadImage> {
  late File _image;

  final picker = ImagePicker();
  TextEditingController marqueController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController vitesseController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController couleurController = TextEditingController();
  TextEditingController disponibleController = TextEditingController();
  bool editMode = false;

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future upload() async {
    final uri = Uri.parse("http://192.168.43.245/addimage/upload.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['marque'] = marqueController.text;
    request.fields['Modele'] = modelController.text;
    request.fields['vitesses'] = vitesseController.text;
    request.fields['nbr_places'] = placeController.text;
    request.fields['Prix'] = prixController.text;
    request.fields['Couleur'] = couleurController.text;
    request.fields['Disponibilite'] = disponibleController.text;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Image Not Uploaded');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Center(child: Text('AJOUTES')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: marqueController,
                  decoration: InputDecoration(labelText: 'Marque'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: modelController,
                  decoration: InputDecoration(labelText: 'Modele'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: vitesseController,
                  decoration: InputDecoration(labelText: 'Nomber Vitesses'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: placeController,
                  decoration: InputDecoration(labelText: 'Nomber Place'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: prixController,
                  decoration: InputDecoration(labelText: 'Prix'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: couleurController,
                  decoration: InputDecoration(labelText: 'Couleur'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: disponibleController,
                  decoration: InputDecoration(labelText: 'Disponibilite'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: () {
                  choiceImage();
                },
              ),
              Container(
                // child: _image == null
                //     ? Text('No Image Selected')
                //     : Image.file(_image),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text('upload Image'),
                onPressed: () {
                  upload();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllPersonData(),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
