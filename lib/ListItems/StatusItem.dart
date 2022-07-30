import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/Repository/DBHelper.dart';

class StatusItem extends StatelessWidget {
  QueryDocumentSnapshot snap;

  StatusItem({required this.snap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DBHelper.db
          .collection("Users")
          .where("key", isEqualTo: snap.get("userkey"))
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          var user = snapshot.data!.docs[0];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: user.get("dplink") != ""
                          ? NetworkImage(user.get("dplink"))
                          : AssetImage("assets/images/placeholder.png")
                              as ImageProvider,
                    ),
                    user.get("isActive")
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  user.get("name").toString().split(' ').first,
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/images/placeholder.png"),
          ),
        );
      },
    );
  }
}
