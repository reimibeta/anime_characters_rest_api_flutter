import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io' show Platform;
//class Photo {
//  final int id;
//  final String title;
//  final String image;
//
//  Photo({this.id, this.title, this.image});
//
//  factory Photo.fromJson(Map<String, dynamic> json) {
//    return Photo(
//      id: json['id'] as int,
//      title: json['character'] as String,
//      image: json['image'] as String,
//    );
//  }
//}


class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();

  final String title = "Upload Image Demo";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImageDemo> {
  static final String host = Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';
  static final String uploadEndPoint = host + '/characters/characterimages/';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
//    var token = AuthenticationToken();
//    var tt = token.accessToken();
//    var parsed = json.decode(tt).cast<Map<String, dynamic>>();
//    var data = parsed.map<Token>((json) => Token.fromJson(json));
//    debugPrint(data);
  }

//  List<Photo> parsePhotos(String responseBody) {
//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//
//    return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
//  }

  upload(String fileName) {
    const token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNTkwODk3NjIyLCJqdGkiOiI3NWU2MTY3Y2I0MGU0MmJlOTgyM2IwOWNjNzAzZGY2OCIsInVzZXJfaWQiOjF9.iPbx7b7tPUsaoMxsqpdwRTWAUAeXIL6GNHVaARTETWc";
    Map<String,String> headers = {'Content-Type':'application/x-www-form-urlencoded','authorization':'Bearer $token'};
    http.post(uploadEndPoint,
        body: {
        "image": base64Image,
        "name": fileName,
        "character": "http://127.0.0.1:8000/characters/characters/1/",
        },
        headers: headers)
//    http.delete(uploadEndPoint)
//    http.put(uploadEndPoint, body: {
//      "image": base64Image,
//      "name": fileName,
//      "character": "http://127.0.0.1:8000/characters/characters/1/",
////      "id": "25"
//    })
//    http.post(uploadEndPoint, body: {
//      "image": base64Image,
//      "name": fileName,
//      "character": "http://127.0.0.1:8000/characters/characters/1/",
//      "id": "25"
//    })
    .then((result) {
//      var file = parsePhotos(result.body);
      debugPrint(result.body.toString());
      setStatus(result.statusCode == 200 || result.statusCode == 201 ? result.body : errMessage);
      debugPrint(result.statusCode.toString());
    }).catchError((error) {
//      setStatus(error);
      debugPrint(error.toString());
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Choose Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: startUpload,
              child: Text('Upload Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}