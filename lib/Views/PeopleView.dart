import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:messenger/AppRoutes.dart';
import 'package:messenger/Widgets/TopBar.dart';

import '../Controller/HomeController.dart';

class PeopleView extends GetView {
  HomeController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(toptitle: "People", action1:null, action2: InkWell(
        onTap: (){
          Get.toNamed(AppRoutes.FindPeople);
        },
          child: Icon(Icons.person_add_alt_1))),
          body: Column(
            mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextFormField(
              onChanged: (val) {
                HomeController.searchedOnline.value=val;
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
          Expanded(child: _controller.getAllOnline)
        ],
     ),
    );
  }
}
