import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/firebase_helper.dart';

class LogInProvider extends ChangeNotifier {
  String email = "";
  String password = "";
  var getEmail;
  String? emailValidator(String val) {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)
        ? null
        : "Please enter a valid email";
  }

  final formKey = GlobalKey<FormState>();
  Services services = Services();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(String value) {
    if (value == "") {
      return "Please enter password";
    } else if (value.length < 6) {
      return "Please enter 6 digit password";
    } else {
      return null;
    }
  }

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    getEmail = preferences.getString("email");
    notifyListeners();
  }

  void onLogin(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;
      services.logInUser(context, email, password);
      preferences.setString("email", email);
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
