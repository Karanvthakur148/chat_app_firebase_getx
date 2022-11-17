import 'package:chat_app_firbase/app_configs/string_extension.dart';
import 'package:chat_app_firbase/screens/chating/controller/chat_controller.dart';
import 'package:chat_app_firbase/screens/group_info/controller/group_info_controller.dart';
import 'package:chat_app_firbase/screens/homepage/screen/home_page.dart';
import 'package:chat_app_firbase/services/data_base_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupInfoScreen extends GetView<GroupInfoController> {
  static const String routeName = "/groupInfoScreen";

  const GroupInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.find<ChatController>();
    controller.onInit();
    chatController.onInit();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Group Info"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Exit"),
                        content: const Text(
                            "Are you sure you want to exit the group?"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                DataBaseService(
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .toggleGroupJoin(
                                        chatController.groupId.value,
                                        chatController.userName.value,
                                        chatController.groupName.value)
                                    .whenComplete(() {
                                  Get.offAllNamed(HomePage.routeName);
                                });
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              )),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Theme.of(context).primaryColor.withOpacity(0.2)),
            child: Row(children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  chatController.groupName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                children: [
                  Text(
                    "Group:${chatController.groupName.toString().inCaps}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                      "Admin: ${controller.getName(chatController.adminName.value)}"
                          .capitalizeFirstOfEach)
                ],
              )
            ]),
          ),
          Obx(() {
            return membersList();
          })
        ]),
      ),
    );
  }

  membersList() {
    return StreamBuilder(
        stream: controller.members.value,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data["members"] != null) {
              if (snapshot.data["members"].length != 0) {
                return ListView.builder(
                    itemCount: snapshot.data["members"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 10.h),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              controller
                                  .getName(snapshot.data["members"][index])
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp),
                            ),
                          ),
                          title: Text(controller
                              .getName(snapshot.data["members"][index])
                              .inCaps),
                          subtitle: Text(controller
                              .getId(snapshot.data["members"][index])),
                        ),
                      );
                    });
              } else {
                return Center(child: Text("No members"));
              }
            } else {
              return Center(child: Text("No members"));
            }
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }
        });
  }
}
