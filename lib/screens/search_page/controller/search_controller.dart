import 'package:chat_app_firbase/services/data_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/db.dart';

class SearchController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool hasUserSearch = false.obs;
  RxBool isJoined = false.obs;

  RxString userName = ''.obs;

  QuerySnapshot? searchSnapShot;
  User? user;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getCurrentUserIdAndName();
    super.onInit();
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  getCurrentUserIdAndName() async {
    await Db.getUserName().then((value) {
      userName.value = value!;
    });
    user = FirebaseAuth.instance.currentUser;
  }

  initiateSearchMethode() async {
    if (searchController.text.isNotEmpty) {
      isLoading.value = true;
      await DataBaseService()
          .searchByName(searchController.text)
          .then((snapshot) {
        searchSnapShot = snapshot;
        isLoading.value = false;
        hasUserSearch.value = true;
      });
    } else {}
  }
}
