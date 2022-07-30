import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messenger/AppPages.dart';
import 'package:messenger/AppRoutes.dart';
import 'package:messenger/Repository/DBHelper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings=Settings(persistenceEnabled: true,cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(Phoenix(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Messenger",
      initialRoute: DBHelper.auth.currentUser!=null?AppRoutes.Home:AppRoutes.Selector,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(foregroundColor:Colors.black,backgroundColor: Colors.white),
        fontFamily: GoogleFonts.lato().fontFamily,
        backgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(foregroundColor: Colors.black,backgroundColor: Colors.white),
        fontFamily: GoogleFonts.lato().fontFamily,
        backgroundColor: Colors.white,
      ) ,
    );
  }
}
