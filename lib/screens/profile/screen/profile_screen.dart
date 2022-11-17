import 'package:chat_app_firbase/app_configs/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/app_appbar.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  static const String routeName = "/profileScreen";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppAppbar.titleWithBackButton(title: 'Profile', context: context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 120.h),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Icon(
              Icons.account_circle,
              size: 150.sp,
              color: Colors.grey[700],
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Full Name',
                  style: TextStyle(fontSize: 16.sp),
                ),
                Obx(() {
                  return Text(
                    controller.userName.toString().inCaps,
                    style: TextStyle(fontSize: 16.sp),
                  );
                })
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email',
                  style: TextStyle(fontSize: 16.sp),
                ),
                Obx(() {
                  return Text(
                    controller.email.toString(),
                    style: TextStyle(fontSize: 16.sp),
                  );
                })
              ],
            ),
          ]),
        ));
  }
}
