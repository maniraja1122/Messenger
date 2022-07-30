import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/Controller/HomeController.dart';
import 'package:messenger/Models/Messages.dart';

import '../AppRoutes.dart';

class PersonItemOnline extends StatelessWidget {
  QueryDocumentSnapshot snap;
  String searched;

  PersonItemOnline({required this.searched, required this.snap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snap
        .get("name")
        .toString()
        .toLowerCase()
        .contains(searched.toLowerCase())) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Card(
          child: ListTile(
            leading: InkWell(
              onTap: () {
                HomeController.openedChat = snap.get("key");
                Get.toNamed(AppRoutes.MessageBox);
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: snap.get("dplink") == ""
                        ? AssetImage("assets/images/placeholder.png")
                            as ImageProvider
                        : NetworkImage(snap.get("dplink")),
                  ),
                  snap.get("isActive")
                      ? CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.green,
                          ))
                      : SizedBox()
                ],
              ),
            ),
            title: Text(
              snap.get("name"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: InkWell(
              onTap: () async {
                Get.showSnackbar(GetSnackBar(message: "Hand Waved to "+snap.get("name"),duration: Duration(seconds: 5),));
                await Get.find<HomeController>().SendMessage(snap.get("key"), Messages(key: DateTime.now().microsecondsSinceEpoch, message: "👋", isImage: false, isAudio: false, link: ""));
              },
                child: CircleAvatar(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.waving_hand_outlined))),
          ),
        ),
      );
    }
    return SizedBox();
  }
}
