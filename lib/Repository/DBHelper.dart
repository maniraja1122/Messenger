

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DBHelper {
  static var db = FirebaseFirestore.instance;
  static var auth = FirebaseAuth.instance;
  static var storage = FirebaseStorage.instance;
}