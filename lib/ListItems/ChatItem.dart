import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/AppRoutes.dart';
import 'package:messenger/Controller/HomeController.dart';
import 'package:messenger/Repository/DBHelper.dart';
import 'dart:developer' as dev;

class ChatItem extends StatelessWidget {
  QueryDocumentSnapshot snap;
  String searched;

  ChatItem({Key? key, required this.snap, required this.searched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DBHelper.db
          .collection("Users")
          .where("key", isEqualTo: snap.get("user2"))
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data!.docs[0];
          if (user
              .get("name")
              .toString()
              .toLowerCase()
              .contains(searched.toLowerCase())) {
            return InkWell(
              onTap: () {
                HomeController.openedChat = snap.get("user2");
                Get.toNamed(AppRoutes.MessageBox);
              },
              child: Card(
                child: ListTile(
                  leading: user.get("dplink") == ""
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/placeholder.png"),
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(user.get("dplink")),
                        ),
                  title: Text(
                    user.get("name"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: StreamBuilder(
                    stream: DBHelper.db
                        .collection("Messages")
                        .where("chatkey", isEqualTo: snap.get("chatkey"))
                        .orderBy("key", descending: true)
                        .limit(1)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.length > 0) {
                          var item = snapshot.data!.docs[0];
                          if (!item.get("isImage") && !item.get("isAudio")) {
                            return Text(item.get("message"));
                          } else if (item.get("isImage")) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.photo,
                                  size: 16,
                                ),
                                Text("Photo")
                              ],
                            );
                          } else if (item.get("isAudio")) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.mic,
                                  size: 16,
                                ),
                                Text("Voice Message")
                              ],
                            );
                          }
                        }
                      }
                      return Text("");
                    },
                  ),
                ),
              ),
            );
          }
          return SizedBox();
        }
        return SizedBox();
      },
    );
  }
}
