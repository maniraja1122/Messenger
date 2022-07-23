


import 'package:get/get_navigation/get_navigation.dart';
import 'package:messenger/AppRoutes.dart';
import 'package:messenger/Register/Login.dart';
import 'package:messenger/Register/Selector.dart';
import 'package:messenger/Register/Signup.dart';
import 'package:messenger/Views/HomeView.dart';

class AppPages{
  static var pages=<GetPage>[
    GetPage(name: AppRoutes.Selector, page:()=>Selector()),
    GetPage(name: AppRoutes.Login, page: ()=>Login()),
    GetPage(name: AppRoutes.Signup, page:()=>Signup()),
    GetPage(name: AppRoutes.Home, page:()=>HomeView()),
  ];
}