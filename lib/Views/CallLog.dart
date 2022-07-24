import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:messenger/AppRoutes.dart';

import '../Controller/HomeController.dart';
import '../Widgets/TopBar.dart';

class CallLogView extends GetView {
  HomeController _controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:TopBar(toptitle: "Call Logs", action2: InkWell(
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
          }, child: Icon(Icons.logout)), action1: Icon(Icons.clear_all)),
      body: Center(child: Text("Call Log"),),
    );
  }
}
