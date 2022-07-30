import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/Controller/HomeController.dart';


class findPeopleView extends StatelessWidget {
  const findPeopleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _controller=Get.find();
    return Scaffold(
      appBar: AppBar(title: Text("Add Person",style: TextStyle(fontWeight: FontWeight.bold),),centerTitle: true,),
      body: _controller.getAllPeopleList,
    );
  }
}
