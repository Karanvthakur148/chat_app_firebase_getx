import 'package:chat_app_firbase/provider/provider/registration_provider.dart';
import 'package:chat_app_firbase/provider/screen/log_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/widgets.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);

    return Scaffold(
        body: provider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Single Chat",
                              style: TextStyle(
                                  fontSize: 40.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Create your account now to chat and explore",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.w400),
                            ),
                            Image.asset("assets/register.png"),
                            // TextFormField(
                            //     decoration: textInputDecoration.copyWith(
                            //       labelText: "Full Name",
                            //       prefixIcon: Icon(
                            //         Icons.person,
                            //         color: Theme.of(context).primaryColor,
                            //       ),
                            //     ),
                            //     onChanged: (value) {
                            //       provider.fullName = value;
                            //     },
                            //     validator: (value) {
                            //       return provider.nameValidator(value!);
                            //     }),
                            // SizedBox(height: 15.h),
                            Consumer<RegistrationProvider>(
                                builder: (context, providerValue, child) {
                              return TextFormField(
                                  autovalidateMode:
                                      providerValue.autoValidateMode,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: "Email",
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    providerValue.email = value;
                                  },
                                  validator: (value) {
                                    return providerValue.emailValidator(value!);
                                  });
                            }),
                            SizedBox(height: 15.h),
                            Consumer<RegistrationProvider>(
                                builder: (context, providerValue, child) {
                              return TextFormField(
                                  obscureText: true,
                                  autovalidateMode:
                                      providerValue.autoValidateMode,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: "Password",
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    providerValue.password = value;
                                  },
                                  validator: (value) {
                                    return providerValue
                                        .passwordValidator(value!);
                                  });
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
                                  provider.onRegistration(context);
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
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          nextScreenReplace(
                                              context, const LoginScreen());
                                        }),
                                ])),
                          ]),
                    ))));
  }
}
