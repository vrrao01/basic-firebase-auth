import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _getUser(User fbUser){
    if(fbUser == null){
      return null;
    }
    else{
      return fbUser;
    }
  }


  Future signIn(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _getUser(user);
    } catch(error) {
      return null;
    }
  }

  Future register(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _getUser(user);
    } catch(error){
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(error){
      return null;
    }
  }


}