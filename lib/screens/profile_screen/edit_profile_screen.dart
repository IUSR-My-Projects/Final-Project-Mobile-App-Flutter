import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل الملف الشخصي'),
      ),
      body: Center(
        child: currentUser?.isAnonymous ?? true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'لا يمكن تعديل البيانات للمستخدمين المجهولين.',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: TextEditingController(
                        text: userProvider.currentUser?.displayName),
                    decoration: InputDecoration(labelText: 'الاسم'),
                    onChanged: (value) {
                      userProvider.updateDisplayName(value);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await userProvider.saveChanges();
                      Fluttertoast.showToast(
                        msg: 'تم حفظ التغييرات بنجاح',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    },
                    child: Text('حفظ التغييرات'),
                  ),
                ],
              ),
      ),
    );
  }
}