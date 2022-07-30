import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:messenger/Controller/HomeController.dart';

import '../Widgets/TopBar.dart';

class ChatView extends GetView {
  HomeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          toptitle: "Chats",
          action1: InkWell(
              onTap: () async {
                await _controller.ChangeDP();
              },
              child: Icon(Icons.camera_alt)),
          action2: InkWell(onTap: () async {
            await HomeController.addStatus();
          },child: Icon(CupertinoIcons.pencil_circle))),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextFormField(
              onChanged: (val) {
                HomeController.searchedTerm.value=val;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
          Container(height: 88,child: _controller.getStatus),
          Expanded(child: _controller.getAllChats),
        ],
      ),
    );
  }
}
