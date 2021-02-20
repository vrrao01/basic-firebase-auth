import 'package:flutter/material.dart';
import 'package:image_upload_auth/services/auth.dart';
import 'package:image_upload_auth/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool loading = false;

  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return loading? (){} : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Sign In'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              print('Toggle Called');
              widget.toggle();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: formFieldDecoration.copyWith(hintText: 'Email'),
                validator: (value)=> value.isEmpty? 'Enter an email':null,
                onChanged: (value) {setState(() {
                  email = value;
                });},
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: formFieldDecoration.copyWith(hintText: 'Password'),
                validator: (value)=> value.length<8? 'Password must be at least 8 characters':null,
                onChanged: (value) {setState(() {
                  pass = value;
                });},
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.blueAccent[100],
                child: Text('Sign In'),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _authService.signIn(email, pass);
                    if(result == null){
                      setState(() {
                        errorMessage = 'Invalid credentials';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10.0,),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14.0),

              )
            ],
          ),
        ),
      ),
    );
  }
}
