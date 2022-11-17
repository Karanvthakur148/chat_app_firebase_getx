import 'package:chat_app_firbase/screens/homepage/screen/home_page.dart';
import 'package:chat_app_firbase/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../services/db.dart';

class RegistrationController extends GetxController {
  RxString fullName = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  final RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();
  Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;
  String? emailValidator(String val) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)
        ? null
        : "Please enter a valid email";
  }

  String? passwordValidator(String value) {
    if (value == "") {
      return "Please enter password";
    } else if (value.length < 6) {
      return "Please enter 6 digit password";
    } else {
      return null;
    }
  }

  String? nameValidator(String value) {
    if (value == "") {
      return "Name cannot be empty";
    } else {
      return null;
    }
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      autoValidateMode.value = AutovalidateMode.disabled;
      isLoading.value = true;
      await authServices
          .registerUserWithEmail(fullName.value, email.value, password.value)
          .then((value) async {
        if (value == true) {
          await Db.saveUserLoggedInStatus(true);
          await Db.saveUserEmail(email.value);
          await Db.saveUserName(fullName.value);
          // Get.offAndToNamed(HomePage.routeName);

          Get.offAllNamed(HomePage.routeName);
        } else {
          Fluttertoast.showToast(msg: value.toString());
          //showSnackbar(Get.context, Colors.red, value);
          isLoading.value = false;
        }
      });
    } else {
      autoValidateMode.value = AutovalidateMode.always;
    }
  }
}
