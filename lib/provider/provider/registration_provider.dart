import 'package:chat_app_firbase/provider/screen/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationProvider extends ChangeNotifier {
  String fullName = "";
  String email = "";
  String password = "";
  final bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  Services services = Services();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

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

  void onRegistration(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.disabled;
      services.createUser(context, email, password);
      preferences.setString("email", email);
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
