import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:messenger/Controller/HomeController.dart';

import '../Repository/DBHelper.dart';



class MessageBoxAppBar extends StatelessWidget with PreferredSizeWidget {
  const MessageBoxAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DBHelper.db
          .collection("Users")
          .where("key", isEqualTo: HomeController.openedChat)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          var visiteduser = snapshot.data!.docs[0];
          final DateTime now =
          DateTime.fromMicrosecondsSinceEpoch(visiteduser.get("lastSeen"));
          final DateFormat formatter = DateFormat('E');
          final String formatted = formatter.format(now);
          return AppBar(
            leadingWidth: 25 ,
            titleSpacing:0 ,
            centerTitle: false,
            title: ListTile(
              leading: visiteduser.get("dplink") == ""
                  ? CircleAvatar(radius: 25,backgroundImage:AssetImage("assets/images/placeholder.png") as ImageProvider ,)
                  : CircleAvatar(radius: 25,backgroundImage:NetworkImage(visiteduser.get("dplink")),),
              title: Text(visiteduser.get("name"),style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(visiteduser.get("isActive")
                  ? "Online"
                  : "Last Seen on $formatted"),
            ),
            actions: [Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: InkWell(onTap:() async {
                var res=await FlutterPhoneDirectCaller.callNumber("03331234567");
                await Get.find<HomeController>().CallUser(visiteduser.get("key"));
              },child: Icon(Icons.phone,color: Colors.blue.shade700,),),
            )],
          );
        }
        return AppBar();
      },
    );;
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
