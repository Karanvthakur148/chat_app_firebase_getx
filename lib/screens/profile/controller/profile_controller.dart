import 'dart:developer';

import 'package:get/get.dart';

import '../../../services/db.dart';

class ProfileController extends GetxController {
  RxString userName = "".obs;
  RxString email = "".obs;
  @override
  void onInit() {
    gettingUserData();
    super.onInit();
    log("vfgmhfgfdhf");
  }

  gettingUserData() async {
    await Db.getUserEmail().then((value) {
      email.value = value!;
    });
    await Db.getUserName().then((value) {
      userName.value = value!;
    });
  }
}
