

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:messenger/Controller/HomeController.dart';
import 'package:messenger/Views/CallLog.dart';
import 'package:messenger/Views/ChatView.dart';
import 'package:messenger/Views/PeopleView.dart';

class HomeView extends GetView{
  @override
  Widget build(BuildContext context) {
    var _controller=Get.put(HomeController());
    return DefaultTabController(length: 3, child:
      Scaffold(
        bottomNavigationBar: TabBar(labelColor: Colors.black,unselectedLabelColor: Colors.grey,tabs: [
          Tab(icon:Icon(Icons.messenger_rounded),),
          Tab(icon:Icon(Icons.people_alt),),
          Tab(icon:Icon(Icons.phone_in_talk),),
        ],),
        body: TabBarView(
          children: [
            ChatView(),PeopleView(),CallLogView()
          ],
        ),
      ),
    );
  }

}