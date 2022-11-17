import 'package:chat_app_firbase/screens/homepage/screen/home_page.dart';
import 'package:chat_app_firbase/services/data_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../services/auth_services.dart';
import '../../../../services/db.dart';

class LogInController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  void onLogin() async {
    if (formKey.currentState!.validate()) {
      autoValidateMode.value = AutovalidateMode.disabled;
      isLoading.value = true;
      await authServices
          .loginWithEmail(email.value, password.value)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email.value);

          await Db.saveUserLoggedInStatus(true);
          await Db.saveUserEmail(email.value);
          await Db.saveUserName(snapshot.docs[0]["fullName"]);
          Get.offAllNamed(HomePage.routeName);
        } else {
          Fluttertoast.showToast(msg: value.toString());
          //showSnackbar(Get.context, Colors.red, value);
          isLoading.value = false;
        }
      });
    } else {
      autoValidateMode.value = AutovalidateMode.always;
      // RoundedButtonController.errorReset(loginButton);
    }
  }

  // login() async {
  //   if (formKey.currentState!.validate()) {
  //     _isLoading.value = true;
  //     await authService
  //         .loginWithUserNameandPassword(email, password)
  //         .then((value) async {
  //       if (value == true) {
  //         QuerySnapshot snapshot =
  //             await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //                 .gettingUserData(email);
  //         // saving the values to our shared preferences
  //         await Db.saveUserLoggedInStatus(true);
  //         await HelperFunctions.saveUserEmailSF(email);
  //         await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
  //         //  nextScreenReplace(context, const HomePage());
  //       } else {
  //         // showSnackbar(context, Colors.red, value);
  //
  //         _isLoading.value = false;
  //       }
  //     });
  //   }
  // }
}
