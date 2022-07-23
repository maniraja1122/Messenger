import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:messenger/AppRoutes.dart';

class CallLogView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Logs"),
        actions: [InkWell(
            onTap: () {
              showDialog(context: context, builder: (c) =>
                  AlertDialog(
                    title: Text("Log Out"),
                    content: Text("Do you want to log out?"),
                    actions: [
                      ElevatedButton(onPressed: () {Get.offAllNamed(AppRoutes.Selector);}, child: Text("Yes")),
                      ElevatedButton(onPressed: () {Get.back();}, child: Text("No")),
                    ],
                  ));
            }, child: Icon(Icons.logout))
        ],
      ),
    );
  }
}
