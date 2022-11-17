import 'dart:developer';

import 'package:chat_app_firbase/app_configs/string_extension.dart';
import 'package:chat_app_firbase/screens/chating/screen/chat_screen.dart';
import 'package:chat_app_firbase/screens/search_page/controller/search_controller.dart';
import 'package:chat_app_firbase/services/data_base_service.dart';
import 'package:chat_app_firbase/utils/widgets/app_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<SearchController> {
  static const String routeName = "/searchScreen";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar.titleWithBackButton(title: "Search", context: context),
      body: Column(children: [
        Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Row(children: [
            Expanded(
                child: TextField(
              controller: controller.searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search groups....",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16.sp)),
            )),
            GestureDetector(
              onTap: () {
                controller.initiateSearchMethode();
              },
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ),
        controller.isLoading.value
            ? Center(
                child: Obx(() {
                  return CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  );
                }),
              )
            : Obx(() {
                return groupList();
              })
      ]),
    );
  }

  groupList() {
    return controller.hasUserSearch.value
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: controller.searchSnapShot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                  controller.userName.value,
                  controller.searchSnapShot!.docs[index]["groupName"],
                  controller.searchSnapShot!.docs[index]["admin"],
                  controller.searchSnapShot!.docs[index]["groupId"],
                  context);
            })
        : Container(
            height: 100.h,
            child: Center(child: Text("Search here.......")),
          );
  }

  Widget groupTile(String userName, String groupName, String admin,
      String groupId, BuildContext context) {
    //function to whether chek user  already exist  in group
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      leading: CircleAvatar(
        radius: 30.r,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      title: Text(
        groupName.inCaps,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle:
          Text("Admin: ${controller.getName(admin)}".capitalizeFirstOfEach),
      trailing: Obx(() {
        return InkWell(
          onTap: () async {
            await DataBaseService(uid: controller.user!.uid)
                .toggleGroupJoin(groupId, userName, groupName);
            if (controller.isJoined.value) {
              log("if");

              controller.isJoined.value = !controller.isJoined.value;
              Fluttertoast.showToast(msg: "Left the group $groupName");
            } else {
              log("else");
              controller.isJoined.value = !controller.isJoined.value;
              Fluttertoast.showToast(msg: "Successfully joined the group");
              Future.delayed(Duration(seconds: 2), () {
                Get.toNamed(ChatScreen.routeName);
              });
            }
          },
          child: controller.isJoined.value
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.black,
                      border: Border.all(color: Colors.white, width: 1)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(
                    "Joined",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Theme.of(context).primaryColor,
                      border: Border.all(color: Colors.white, width: 1)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(
                    "Join Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        );
      }),
    );
  }

  joinedOrNot(
      String userName, String groupId, String groupName, String admin) async {
    await DataBaseService(uid: controller.user!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
      log('bollvalue : ' + value.toString());
      controller.isJoined.value = value;
      controller.update();
    });
  }
}
