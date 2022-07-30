import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/AppRoutes.dart';
import 'package:messenger/ListItems/CallLogItem.dart';
import 'package:messenger/ListItems/ChatItem.dart';
import 'package:messenger/ListItems/MessageItem.dart';
import 'package:messenger/ListItems/PersonItem.dart';
import 'package:messenger/ListItems/StatusItem.dart';
import 'package:messenger/Models/CallLog.dart';
import 'package:messenger/Models/Chats.dart';
import 'package:messenger/Models/Messages.dart';
import 'package:messenger/Models/Status.dart';
import 'package:messenger/Views/StatusViewer.dart';
import 'dart:developer' as dev;
import '../ListItems/PersonItemOnline.dart';
import '../Repository/DBHelper.dart';

class HomeController extends GetxController {
  static var searchedTerm = "".obs;
  static var searchedOnline = "".obs;
  static var openedChat = "";
  var voiceIconSize = 24.0.obs;
  var message = "";

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
    await DBHelper.auth.signOut();
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
  var getStatus = StreamBuilder(
    stream: DBHelper.db
        .collection("Chats")
        .where("user1", isEqualTo: DBHelper.auth.currentUser!.uid)
        .snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasData) {
        var arr = snapshot.data!.docs.map((e) => e.get("user2")).toList();
        if (arr.isNotEmpty) {
          return StreamBuilder(
            stream: DBHelper.db
                .collection("Status")
                .where("userkey", whereIn: arr)
                .orderBy("key")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                var statusList = snapshot.data!.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: statusList.length + 1,
                  itemBuilder: (c, i) {
                    if (i == 0) {
                      return Get
                          .find<HomeController>()
                          .addStatusButton;
                    }
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) =>
                                  StatusViewer(
                                    arr: statusList,
                                    index: i - 1,
                                  )));
                        },
                        child: StatusItem(snap: statusList[i - 1]));
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else {
          return Align(
              alignment: Alignment.centerLeft,
              child: Get
                  .find<HomeController>()
                  .addStatusButton);
        }
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  var addStatusButton = StreamBuilder(
    stream: DBHelper.db
        .collection("Status")
        .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
        .snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data!.docs.isEmpty) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8),
            child: InkWell(
              onTap: () async {
                await addStatus();
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Your Story",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8),
            child: InkWell(
              onTap: () async {
                await addStatus();
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                    NetworkImage(snapshot.data!.docs[0].get("link")),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Your Story",
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ),
          );
        }
      } else {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8),
          child: InkWell(
            onTap: () async {
              await addStatus();
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Your Story",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
          ),
        );
      }
    },
  );

  var getAllPeopleList = StreamBuilder(
    stream: DBHelper.db
        .collection("Users")
        .where("key", isNotEqualTo: DBHelper.auth.currentUser!.uid)
        .snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasData) {
        var arr = snapshot.data!.docs;
        if (arr.length > 0) {
          return ListView.separated(
            itemCount: arr.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () async {
                    openedChat = arr[index].get("key");
                    Get.toNamed(AppRoutes.MessageBox);
                  },
                  child: PersonItem(snap: arr[index]));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
        } else {
          return Center(
              child: Text(
                "Nothing to show !",
                style: TextStyle(fontSize: 25),
              ));
        }
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  var getAllMessages = StreamBuilder(
    stream: DBHelper.db
        .collection("Chats")
        .where("user1", isEqualTo: DBHelper.auth.currentUser!.uid)
        .snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasData) {
        var arr = snapshot.data!.docs;
        arr =
            arr.where((element) => element.get("user2") == openedChat).toList();
        if (arr.isEmpty) {
          return Center(
              child: Text(
                "Start a Chat !",
                style: TextStyle(fontSize: 25),
              ));
        }
        var currentchat = arr[0];
        return StreamBuilder(
          stream: DBHelper.db
              .collection("Messages")
              .where("chatkey", isEqualTo: currentchat.get("chatkey"))
              .orderBy("key")
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              arr = arr.reversed.toList();
              return ListView.builder(
                reverse: true,
                itemCount: arr.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (dir) {
                        arr[index].reference.delete();
                      },
                      child: MessageItem(snap: arr[index]));
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  var getAllChats = StreamBuilder(
    stream: DBHelper.db
        .collection("Chats")
        .where("user1", isEqualTo: DBHelper.auth.currentUser!.uid)
        .orderBy("lastSend", descending: true)
        .snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasData) {
        var arr = snapshot.data!.docs;
        if (arr.isEmpty) {
          return Center(
            child: Text(
              "No Chats",
              style: TextStyle(fontSize: 25),
            ),
          );
        }
        return ListView.builder(
          itemCount: arr.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() =>
                ChatItem(
                  snap: arr[index],
                  searched: searchedTerm.value,
                ));
          },
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  var getAllOnline = StreamBuilder(
    stream: DBHelper.db
        .collection("Chats")
        .where("user1", isEqualTo: DBHelper.auth.currentUser!.uid)
        .snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasData) {
        var otherids = snapshot.data!.docs.map((e) => e.get("user2")).toList();
        return StreamBuilder(
          stream: DBHelper.db
              .collection("Users")
              .where("key", whereIn: otherids)
              .orderBy("isActive", descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              var arr = snapshot.data!.docs;
              return ListView.builder(
                itemCount: arr.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () async {
                        await HomeController.addStatus();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey.shade200,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 35,
                              ),
                            ),
                            title: Text(
                              "Your Story",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Add to your story"),
                          ),
                        ),
                      ),
                    );
                  }
                  return Obx(() =>
                      PersonItemOnline(
                        snap: arr[index - 1],
                        searched: searchedOnline.value,
                      ));
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  var getAllCallLogs = StreamBuilder(
    stream: DBHelper.db
        .collection("CallLog")
        .where("user1", isEqualTo: DBHelper.auth.currentUser!.uid)
        .orderBy("key", descending: true)
        .snapshots(),
    builder: (BuildContext context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.hasError) {
        dev.log(snapshot.error.toString());
      }
      else if (snapshot.hasData) {
        var arr = snapshot.data!.docs;
        if(arr.isEmpty){
          return Center(child: Text("Call Log is Empty !!!",style: TextStyle(fontSize: 22),),);
        }
        return ListView.builder(
            itemBuilder: (c, i) => CallLogItem(snap: arr[i]),
            itemCount: arr.length);
      }
      return Center(child: CircularProgressIndicator());
    },
  );

  //Functions

  Future<void> ChangeDP() async {
    var file = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1800);
    if (file != null) {
      var newfile = File(file.path);
      await DBHelper.storage
          .ref()
          .child("ProfilePhotos")
          .child(DBHelper.auth.currentUser!.uid)
          .putFile(newfile);
      var newlink = await DBHelper.storage
          .ref()
          .child("ProfilePhotos")
          .child(DBHelper.auth.currentUser!.uid)
          .getDownloadURL();
      var currentuser = await DBHelper.db
          .collection("Users")
          .where("key", isEqualTo: DBHelper.auth.currentUser!.uid)
          .get();
      await currentuser.docs[0].reference.update({"dplink": newlink});
    }
  }

  static Future<void> addStatus() async {
    var file = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (file != null) {
      var newfile = File(file.path);
      var myref = DBHelper.storage
          .ref()
          .child("Status")
          .child(DBHelper.auth.currentUser!.uid);
      await myref.putFile(newfile);
      var statuslink = await myref.getDownloadURL();
      var check = await DBHelper.db
          .collection("Status")
          .where("userkey", isEqualTo: DBHelper.auth.currentUser!.uid)
          .get();
      if (check.docs.isEmpty) {
        await DBHelper.db.collection("Status").add(
            Status(userkey: DBHelper.auth.currentUser!.uid, link: statuslink)
                .toMap());
      } else {
        await check.docs[0].reference.update(
            {"key": DateTime
                .now()
                .microsecondsSinceEpoch, "link": statuslink});
      }
    }
  }

  static Future<QueryDocumentSnapshot<Map<String, dynamic>>> AddChat(
      String user2) async {
    var check = await DBHelper.db
        .collection("Chats")
        .where("user1", isEqualTo: DBHelper.auth.currentUser!.uid)
        .where("user2", isEqualTo: user2)
        .get();
    if (check.docs.isEmpty) {
      await DBHelper.db.collection("Chats").add(
          Chats(user1: DBHelper.auth.currentUser!.uid, user2: user2).toMap());
      await DBHelper.db.collection("Chats").add(
          Chats(user1: user2, user2: DBHelper.auth.currentUser!.uid).toMap());
      var createdchat = await DBHelper.db
          .collection("Chats")
          .where("user1", isEqualTo: DBHelper.auth.currentUser!.uid)
          .where("user2", isEqualTo: user2)
          .get();
      return createdchat.docs[0];
    }
    return check.docs[0];
  }

  Future<void> SendMessage(String recuser, Messages message) async {
    var getChat = await AddChat(recuser);
    message.chatkey = getChat.get("chatkey");
    await DBHelper.db.collection("Messages").add(message.toMap());
    var otherchat = await DBHelper.db
        .collection("Chats")
        .where("user1", isEqualTo: recuser)
        .where("user2", isEqualTo: DBHelper.auth.currentUser!.uid)
        .get();
    message.chatkey = otherchat.docs[0].get("chatkey");
    await DBHelper.db.collection("Messages").add(message.toMap());
    await getChat.reference
        .update({"lastSend": DateTime
        .now()
        .microsecondsSinceEpoch});
    await otherchat.docs[0].reference
        .update({"lastSend": DateTime
        .now()
        .microsecondsSinceEpoch});
  }

  Future<void> CallUser(String recuser) async {
    await DBHelper.db.collection("CallLog").add(CallLog(
        user1: DBHelper.auth.currentUser!.uid,
        user2: recuser,
        isFirstCaller: true).toMap());
    await DBHelper.db.collection("CallLog").add(CallLog(
        user2: DBHelper.auth.currentUser!.uid,
        user1: recuser,
        isFirstCaller: false).toMap());
  }
}
