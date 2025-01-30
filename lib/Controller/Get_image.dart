import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStoreDataBase {
  final User = FirebaseAuth.instance.currentUser;
  String? downloadurl;

  Future getData() async {
    try {
      await downloadurlexapmle();
      return downloadurl;
    } catch (e) {
      debugPrint('erorrr-----$e');
      return null;
    }
  }

  Future<void> downloadurlexapmle() async {
    downloadurl = await FirebaseStorage.instance
        .ref()
        .child('/foldename/' + User!.uid)
        .getDownloadURL();
    debugPrint(downloadurl.toString());
  }
}
