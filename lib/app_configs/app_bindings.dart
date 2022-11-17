import 'package:chat_app_firbase/screens/auth/registration/controller/registration_controller.dart';
import 'package:chat_app_firbase/screens/chating/controller/chat_controller.dart';
import 'package:chat_app_firbase/screens/group_info/controller/group_info_controller.dart';
import 'package:chat_app_firbase/screens/profile/controller/profile_controller.dart';
import 'package:chat_app_firbase/screens/search_page/controller/search_controller.dart';
import 'package:chat_app_firbase/screens/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

import '../screens/auth/login/controller/log_in_controller.dart';
import '../screens/homepage/controller/home_page_controller.dart';

class SplashScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

class HomePageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController(), fenix: true);
  }
}

class LogInPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogInController());
  }
}

class RegistrationPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
  }
}

class SearchScreenPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}

class ProfilePageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

class ChatScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}

class GroupInfoPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupInfoController());
  }
}
