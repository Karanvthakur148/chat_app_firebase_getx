import 'package:chat_app_firbase/provider/provider/home_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                provider.services.signOut(context);
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.remove("email");
              },
              icon: Icon(Icons.logout))
        ],
        title: Text(provider.logInUser!.email.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Messages"),
                Container(
                    height: 450.h,
                    child: SingleChildScrollView(
                        reverse: true,
                        physics: ScrollPhysics(),
                        child: ShowMessage())),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.blue, width: 0.2))),
                      child: TextField(
                          controller: provider.messageController,
                          decoration:
                              InputDecoration(hintText: "Enter Message.....")),
                    )),
                    IconButton(
                        onPressed: () {
                          if (provider.messageController.text.isNotEmpty) {
                            provider.storeMessage
                                .collection("providerMessages")
                                .doc()
                                .set({
                              "messages":
                                  provider.messageController.text.trim(),
                              "user": provider.logInUser!.email.toString(),
                              "time": DateTime.now()
                            });
                            provider.messageController.clear();
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.teal,
                        ))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

class ShowMessage extends StatelessWidget {
  const ShowMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getCurrentUser();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("providerMessages")
            .orderBy("time")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              primary: true,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot x = snapshot.data!.docs[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: provider.logInUser!.email == x["user"]
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              color: provider.logInUser!.email == x["user"]
                                  ? Colors.blue.withOpacity(0.2)
                                  : Colors.amber.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(x["messages"]),
                              SizedBox(height: 5.h),
                              Text(
                                x["user"],
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.green),
                              ),
                            ],
                          ))
                    ],
                  ),
                );
              });
        });
  }
}
