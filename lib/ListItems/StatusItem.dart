import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Repository/DBHelper.dart';

class StatusItem extends StatelessWidget {
  QueryDocumentSnapshot snap;

  StatusItem({required this.snap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DBHelper.db
          .collection("Users")
          .where("key", isEqualTo: snap.get("userkey"))
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if(snapshot.hasData){
          var user=snapshot.data!.docs[0];
          return CircleAvatar(
            radius: 10,
            backgroundImage: user.get("dplink"),
          );
        }
        return CircleAvatar(
          radius: 10,
          backgroundImage: AssetImage("assets/images/placeholder.png"),
        );
      },
    );
  }
}
