import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> updateDisplayName(String displayName) async {
    currentUser = FirebaseAuth.instance.currentUser;
    await currentUser?.updateDisplayName(displayName);
    notifyListeners();
  }

  Future<void> saveChanges() async {
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({'displayName': currentUser!.displayName});
    }
  }
}
