import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Repository/DBHelper.dart';

class CallLogItem extends StatelessWidget {
  QueryDocumentSnapshot snap;

  CallLogItem({required this.snap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now =
    DateTime.fromMicrosecondsSinceEpoch(snap.get("key"));
    final DateFormat formatter = DateFormat('E');
    final String formatted = formatter.format(now);
    return Card(
      child: ListTile(
        leading: snap.get("isFirstCaller")
            ? Icon(
                Icons.call_made_outlined,
                color: Colors.green,
              )
            : Icon(
                Icons.call_received_outlined,
                color: Colors.red,
              ),
        title: StreamBuilder(
          stream: DBHelper.db
              .collection("Users")
              .where("key", isEqualTo: snap.get("user2"))
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if(snapshot.hasData){
              return Text(snapshot.data!.docs[0].get("name"));
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
        trailing:Text(formatted),
      ),
    );
  }
}
