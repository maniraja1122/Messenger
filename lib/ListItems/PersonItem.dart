import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PersonItem extends StatelessWidget {
  QueryDocumentSnapshot snap;
  PersonItem({required this.snap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(snap.get("dplink")),
    ),title:Text(snap.get("name"),style: TextStyle(fontWeight: FontWeight.bold),));
  }
}
