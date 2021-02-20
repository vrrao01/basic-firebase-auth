import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_upload_auth/screens/authenticate/authenticate.dart';
import 'package:image_upload_auth/screens/upload/upload.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
