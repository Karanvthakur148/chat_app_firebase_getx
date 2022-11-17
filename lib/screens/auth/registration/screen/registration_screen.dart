import 'dart:developer';

import 'package:chat_app_firbase/screens/auth/login/screen/log_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app_configs/app_constant.dart';
import '../../../../utils/widgets/widgets.dart';
import '../controller/registration_controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  static const String routeName = "/registrationScreen";

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          body: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                )
              : SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 60.h),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DynamicAppConstant.appName,
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "Create your account now to chat and explore",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Image.asset("assets/register.png"),
                              TextFormField(
                                  autovalidateMode:
                                      controller.autoValidateMode.value,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: "Full Name",
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.fullName.value = value;
                                    log(controller.fullName.value);
                                  },
                                  validator: (value) {
                                    return controller.nameValidator(value!);
                                  }),
                              SizedBox(height: 15.h),
                              TextFormField(
                                  autovalidateMode:
                                      controller.autoValidateMode.value,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: "Email",
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.email.value = value;
                                    log(controller.email.value);
                                  },
                                  validator: (value) {
                                    return controller.emailValidator(value!);
                                  }),
                              SizedBox(height: 15.h),
                              TextFormField(
                                  autovalidateMode:
                                      controller.autoValidateMode.value,
                                  obscureText: true,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: "Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.password.value = value;
                                  },
                                  validator: (value) {
                                    return controller.passwordValidator(value!);
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    controller.register();
                                    // login();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text.rich(TextSpan(
                                  text: "Already have an account? ",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Login now",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed(LogInPage.routeName);
                                            // nextScreen(context, const RegisterPage());
                                          }),
                                  ])),
                            ]),
                      ))));
    });
  }
}
