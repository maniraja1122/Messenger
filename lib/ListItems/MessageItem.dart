import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';

import '../Repository/DBHelper.dart';

class MessageItem extends StatelessWidget {
  QueryDocumentSnapshot snap;
  MessageItem({required this.snap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showwidget;
    if(!snap.get("isImage") && !snap.get("isAudio")){
      showwidget = Text(snap.get("message"), style: TextStyle(fontSize: 15),);
    }
    else if(snap.get("isImage")){
      showwidget=Container(
        child: Image.network(snap.get("link"),fit: BoxFit.fitWidth,),
      );
    }
    if(!snap.get("isAudio")) {
      return Container(
        padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        child: Align(
          alignment: (snap.get("sender") != DBHelper.auth.currentUser!.uid
              ? Alignment.topLeft
              : Alignment.topRight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (snap.get("sender") != DBHelper.auth.currentUser!.uid
                  ? Colors.grey.shade200
                  : Colors.blue[200]),
            ),
            padding: EdgeInsets.all(16),
            child: showwidget,
          ),
        ),
      );
    }
    else{
      return Align(
    alignment: (snap.get("sender") != DBHelper.auth.currentUser!.uid
    ? Alignment.topLeft
        : Alignment.topRight),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: VoiceMessage(
        audioSrc: snap.get("link"),
        played: false, // To show played badge or not.
        me: snap.get("sender") == DBHelper.auth.currentUser!.uid, // Set message side.
        contactBgColor: Colors.grey.shade200,
        meBgColor: Colors.blue.shade200,
        contactFgColor: Colors.black87,
        contactPlayIconColor: Colors.white,
      ),
    ),
    );
    }
  }
}
