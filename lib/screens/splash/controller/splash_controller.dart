import 'dart:async';
import 'dart:developer';

import 'package:chat_app_firbase/screens/auth/login/screen/log_in_screen.dart';
import 'package:chat_app_firbase/screens/homepage/screen/home_page.dart';
import 'package:get/get.dart';

import '../../../services/db.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 2), () async {
      getUserLoggedInStatus();
    });
    super.onInit();
  }

  getUserLoggedInStatus() async {
    await Db.getUserLoggedInStatus().then((value) {
      log("value : $value");
      if (value == false || value == null) {
        Get.offAllNamed(LogInPage.routeName);
      } else {
        Get.offAllNamed(HomePage.routeName);
      }
    });
  }
}
