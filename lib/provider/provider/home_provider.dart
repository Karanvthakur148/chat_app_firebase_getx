import 'package:chat_app_firbase/provider/screen/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  Services services = Services();
  User? logInUser = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();

  final storeMessage = FirebaseFirestore.instance;

  getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      logInUser = user;
    }
  }
}
