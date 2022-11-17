import 'package:chat_app_firbase/services/data_base_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../chating/controller/chat_controller.dart';

class GroupInfoController extends GetxController {
  ChatController chatController = Get.find<ChatController>();
  Rx<Stream> members = const Stream.empty().obs;
  @override
  void onInit() {
    getMembers();
    super.onInit();
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  getMembers() async {
    DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(chatController.groupId.value)
        .then((val) {
      members.value = val;
      update();
    });
  }
}
