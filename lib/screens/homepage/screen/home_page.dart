import 'dart:developer';

import 'package:chat_app_firbase/screens/auth/login/screen/log_in_screen.dart';
import 'package:chat_app_firbase/screens/search_page/screen/search_screen.dart';
import 'package:chat_app_firbase/services/data_base_service.dart';
import 'package:chat_app_firbase/utils/widgets/group_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../profile/screen/profile_screen.dart';
import '../controller/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  static const String routeName = "/homePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(SearchScreen.routeName);
                },
                icon: const Icon(Icons.search))
          ],
          centerTitle: true,
          title: Text(
            "Groups",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 27.sp),
          )),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        children: [
          Icon(
            Icons.account_circle,
            size: 120.sp,
          ),
          SizedBox(height: 10.h),
          Center(
            child: Obx(() {
              return Text(
                controller.userName.value,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp),
              );
            }),
          ),
          SizedBox(height: 30.h),
          const Divider(height: 5),
          ListTile(
            onTap: () {
              Get.back();
            },
            selectedColor: Theme.of(context).primaryColor,
            selected: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            leading: const Icon(Icons.group),
            title: const Text("Groups", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () {
              Get.toNamed(ProfileScreen.routeName);
            },
            selectedColor: Theme.of(context).primaryColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            leading: const Icon(Icons.person),
            title: const Text("Profile", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
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
                              controller.singOut();
                              Get.offAllNamed(LogInPage.routeName);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            )),
                      ],
                    );
                  });
            },
            selectedColor: Theme.of(context).primaryColor,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            leading: const Icon(Icons.logout),
            title: const Text("Logout", style: TextStyle(color: Colors.black)),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            popUpDialog(context);
          },
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add, size: 30.sp)),
      body: groupList(),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                controller.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor))
                    : TextField(
                        onChanged: (val) {
                          controller.groupName.value = val;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(20.r)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(20.r)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(20.r)),
                        ),
                      ),
              ]),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.groupName.value != "") {
                      controller.isLoading.value = true;
                      DataBaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(
                              controller.userName.value,
                              FirebaseAuth.instance.currentUser!.uid,
                              controller.groupName.value)
                          .whenComplete(() {
                        controller.isLoading.value = false;
                      });
                      Get.back();
                      Fluttertoast.showToast(
                          msg: "Group created successfully.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }

  groupList() {
    return Obx(
      () {
        return StreamBuilder(
          stream: controller.groups.value,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              log(snapshot.data.toString());
              // return Text('harsh');

              if (snapshot.data["groups"] != null) {
                if (snapshot.data["groups"].length != 0) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data["groups"].length,
                      itemBuilder: (BuildContext context, int index) {
                        int reverseIndex =
                            snapshot.data["groups"].length - index - 1;
                        return GroupTile(
                            groupName: controller
                                .getName(snapshot.data["groups"][reverseIndex]),
                            userName:
                                controller.getName(snapshot.data["fullName"]),
                            groupId: controller
                                .getId(snapshot.data["groups"][reverseIndex]));
                      });
                } else {
                  return noGroupWidget(context);
                }
              } else {
                return noGroupWidget(context);
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }

  noGroupWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  popUpDialog(context);
                },
                child: Icon(Icons.add_circle,
                    color: Colors.grey[700], size: 75.sp)),
            SizedBox(height: 20.h),
            const Text(
              "You've not joined any groups, tap on the add icon to create a group or also from top search button.",
              textAlign: TextAlign.center,
            )
          ]),
    );
  }
}
