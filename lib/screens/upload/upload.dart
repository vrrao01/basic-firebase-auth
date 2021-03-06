import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload_auth/services/auth.dart';
import 'package:image_upload_auth/shared/loading.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  uploadImage() async{
    final _fbStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    image = await _imagePicker.getImage(source: ImageSource.gallery);
    var imageFile = File(image.path);
    if(image != null){
      var snapshot = await _fbStorage.ref()
          .child('$uid/image').putFile(imageFile);
      String downloadURL = await snapshot.ref.getDownloadURL();
      setState(() {
        imagePath = downloadURL;
      });
    }
  }

  String uid = FirebaseAuth.instance.currentUser.uid;
  AuthService _authService = AuthService();
  String imagePath;
  bool loading = true;

  _setURLifExists() async{
    final _fbStorage = FirebaseStorage.instance;
    try{
      imagePath =  await _fbStorage.ref().child('$uid/image').getDownloadURL();
    }
    catch(e){
      print(e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _setURLifExists();
  }

  @override
  Widget build(BuildContext context) {

    return loading? Loading() : Scaffold(
              appBar: AppBar(
                title: Text(
                    'Upload an Image'
                ),
                centerTitle: false,
                actions: [
                  FlatButton.icon(
                    icon: Icon(
                      Icons.logout,
                    ),
                    label: Text('Sign Out'),
                    onPressed: ()=>_authService.signOut(),
                  )
                ],
                backgroundColor: Colors.blueAccent,
              ),
              body: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex:5,
                        child: (imagePath==null) ? Image.network(
                          "https://via.placeholder.com/500x500?text=Upload+an+Image",
                          width: double.infinity,
                          fit:BoxFit.scaleDown,
                        ):Image.network(imagePath,width: double.infinity,fit: BoxFit.scaleDown)
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      flex: 1,
                      child: RaisedButton.icon(
                        color: Colors.blueAccent,
                        icon: Icon(Icons.photo),
                        label: Text('Upload'),
                        onPressed: (){
                          uploadImage();
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
  }
}
