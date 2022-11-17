import 'package:chat_app_firbase/app_configs/string_extension.dart';
import 'package:chat_app_firbase/screens/chating/controller/chat_controller.dart';
import 'package:chat_app_firbase/screens/chating/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupTile extends StatelessWidget {
  final String userName;
  final String groupId;
  final String groupName;

  const GroupTile(
      {Key? key,
      required this.groupName,
      required this.userName,
      required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.put(ChatController()).groupName.value = groupName;
        Get.put(ChatController()).groupId.value = groupId;
        Get.put(ChatController()).userName.value = userName;

        Get.toNamed(ChatScreen.routeName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.r,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(groupName.substring(0, 1).inCaps,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          title: Text(
            groupName.inCaps,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Join the conversation as $userName",
            style: TextStyle(fontSize: 13.sp),
          ),
        ),
      ),
    );
  }
}
