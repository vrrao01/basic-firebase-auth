import 'package:flutter/material.dart';
import 'package:image_upload_auth/screens/authenticate/register.dart';
import 'package:image_upload_auth/screens/authenticate/signin.dart';

    class Authenticate extends StatefulWidget {
      @override
      _AuthenticateState createState() => _AuthenticateState();
    }

    class _AuthenticateState extends State<Authenticate> {

      bool showSignIn = true;

      void toggleScreen(){
        setState(() {
          print('Inside toggleScreen');
          showSignIn = !showSignIn;
        });
      }

      @override
      Widget build(BuildContext context) {
        if(showSignIn){
          return SignIn(toggle: toggleScreen,);
        }
        else{
          return Register(toggle: toggleScreen,);
        }
      }
    }
