import 'package:flutter/material.dart';
import 'package:image_upload_auth/services/auth.dart';
import 'package:image_upload_auth/shared/constants.dart';
import 'package:image_upload_auth/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggle;
  Register({this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool loading = false;

  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Register'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggle(),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: formFieldDecoration.copyWith(hintText: 'Email',prefixIcon: Icon(Icons.email)),
                  validator: (value)=> value.isEmpty? 'Enter an email':null,
                  onChanged: (value) {setState(() {
                    email = value;
                  });},
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: formFieldDecoration.copyWith(hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                  validator: (value)=> value.length<8? 'Password must be at least 8 characters':null,
                  onChanged: (value) {setState(() {
                    pass = value;
                  });},
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.blueAccent[100],
                  child: Text('Register'),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _authService.register(email, pass);
                      if(result == null){
                        setState(() {
                          loading = false;
                          errorMessage = 'Enter a valid email';
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
      ),
    );
  }
}
