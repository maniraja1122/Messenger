import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Repository/DBHelper.dart';
import 'dart:developer'as dev;
class UserImageTop extends StatelessWidget {
  const UserImageTop({Key? key}) : super(key: key);
  static const size=5.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: StreamBuilder(
        stream: DBHelper.db
            .collection("Users")
            .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.hasError){
            dev.log(snapshot.error.toString());
            return CircleAvatar(backgroundImage: AssetImage("assets/images/placeholder.png"),radius: size,);
          }
          else if(snapshot.hasData){
            var user=snapshot.data!.docs[0];
            if(user.get("dplink")==""){
              dev.log("empty");
              return CircleAvatar(backgroundImage: AssetImage("assets/images/placeholder.png"),radius: size,);
            }
            else{
              dev.log("has");
              return CircleAvatar(backgroundImage: NetworkImage(user.get("dplink")),radius: size,);
            }
          }
          dev.log("loading");
          return CircleAvatar(backgroundImage: AssetImage("assets/images/placeholder.png"),radius: size,);
        },
      ),
    );
  }
}
