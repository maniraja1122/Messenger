import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Repository/DBHelper.dart';

class HomeController extends GetxController {
  var searchedTerm = "".obs;

  //Overrided Functions
  @override
  Future<void> onInit() async {
    var currentuser = await DBHelper.db
        .collection("Users")
        .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
        .get();
    await currentuser.docs[0].reference.update(
        {"isActive": true, "lastSeen": DateTime
            .now()
            .microsecondsSinceEpoch});
    super.onInit();
  }

  @override
  Future<void> dispose() async {
    var currentuser = await DBHelper.db
        .collection("Users")
        .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
        .get();
    await currentuser.docs[0].reference.update(
        {"isActive": false, "lastSeen": DateTime
            .now()
            .microsecondsSinceEpoch});
    super.dispose();
  }

  @override
  Future<void> onClose() async {
    var currentuser = await DBHelper.db
        .collection("Users")
        .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
        .get();
    await currentuser.docs[0].reference.update(
        {"isActive": false, "lastSeen": DateTime
            .now()
            .microsecondsSinceEpoch});
    super.onClose();
  }

  //Streams
  StreamBuilder getStatus = StreamBuilder(
    stream: DBHelper.db.collection("Chats").where(
        "user1", isEqualTo: DBHelper.auth.currentUser!.uid).snapshots(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  },);


  //Functions
  Future<void> ChangeDP() async {
    var file = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);
    if (file != null) {
      var newfile = File(file.path);
      await DBHelper.storage.ref().child("ProfilePhotos").child(
          DBHelper.auth.currentUser!.uid).putFile(newfile);
      var newlink = await DBHelper.storage.ref().child("ProfilePhotos").child(
          DBHelper.auth.currentUser!.uid).getDownloadURL();
      var currentuser = await DBHelper.db
          .collection("Users")
          .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
          .get();
      await currentuser.docs[0].reference.update(
          {"dplink": newlink});
    }
  }
}
