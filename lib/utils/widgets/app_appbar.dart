import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppAppbar {
  static AppBar titleWithBackButton(
      {required String title, required BuildContext context}) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      elevation: 0,
      title: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
    );
  }

  static AppBar withOutTitleAndShareButtonBackButton() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      elevation: 0,
    );
  }

  static AppBar titleWithoutBackButton({required String title}) {
    return AppBar(
      centerTitle: true,
      elevation: 1,
      title: Text(
        title,
      ),
    );
  }
}
