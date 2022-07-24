import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:messenger/Widgets/TopBar.dart';

import '../Controller/HomeController.dart';

class PeopleView extends GetView {
  HomeController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(toptitle: "People", action1:Icon(Icons.message), action2: Icon(Icons.person_add_alt_1)),
          body: Center(child: Text("People"),),
    );
  }
}
