import 'package:firebase_auth/firebase_auth.dart';

import '../services/custom_dialog.dart';

class AuthHelper{
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  Future<UserCredential?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog
            .showCustomDialog('No user found for that email.');
       } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog
            .showCustomDialog('Wrong password provided for that user.');

      }else{
        CustomDialog.customDialog
            .showCustomDialog('Wrong password or email provided for that user.');
      }
    }
    return null;
  }
}