import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:messenger/AppRoutes.dart';
import 'package:messenger/Repository/DBHelper.dart';

import '../Controller/HomeController.dart';
import '../Widgets/TopBar.dart';

class CallLogView extends GetView {
  HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          toptitle: "Call Logs",
          action2: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (c) => AlertDialog(
                          title: Text("Log Out"),
                          content: Text("Do you want to log out?"),
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  await _controller.dispose();
                                  Get.offAllNamed(AppRoutes.Selector);
                                  await DBHelper.db.clearPersistence();
                                  Phoenix.rebirth(context);
                                },
                                child: Text("Yes")),
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("No")),
                          ],
                        ));
              },
              child: Icon(Icons.logout)),
          action1: InkWell(onTap:() async {
           var log=await DBHelper.db.collection("CallLog").where("user1",isEqualTo: DBHelper.auth.currentUser!.uid).get();
           log.docs.forEach((element) {element.reference.delete();});
          },child: Icon(Icons.clear_all))),
      body: Center(
        child: _controller.getAllCallLogs,
      ),
    );
  }
}
