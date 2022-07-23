


import 'package:get/get.dart';
import 'package:messenger/Controller/HomeController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}