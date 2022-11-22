import 'package:chat_app_firbase/provider/screen/home_screen.dart';
import 'package:chat_app_firbase/provider/screen/log_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/widgets/widgets.dart';

class Services {
  //in service class we done all firebase auth
  final auth = FirebaseAuth.instance;
  void createUser(context, email, password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {nextScreenReplace(context, const HomeScreen())});
    } catch (e) {
      errorBox(context, e);
    }
  }

  void logInUser(context, email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {nextScreenReplace(context, const HomeScreen())});
    } catch (e) {
      errorBox(context, e);
    }
  }

  void signOut(context) {
    try {
      auth
          .signOut()
          .then((value) => {nextScreenReplace(context, const LoginScreen())});
    } catch (e) {
      errorBox(context, e);
    }
  }

  void errorBox(context, e) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
          );
        });
  }
}
