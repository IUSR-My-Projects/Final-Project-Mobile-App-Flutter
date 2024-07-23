import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:final_project_mobile_app_flutter/providers/auth_provider.dart';
import 'package:final_project_mobile_app_flutter/routes.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('الملف الشخصي'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              bool confirmLogout = await _showLogoutConfirmationDialog(context);
              if (confirmLogout) {
                AuthProvider().signout(context: context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/icon/logo.png'),
              ),
            ),
            SizedBox(height: 30),
            if (user?.isAnonymous ?? false)
              Text(
                'الحساب الخاص بك هو مجهول, لايحتوي على بيانات',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            SizedBox(height: 20),
            Text(
              'اسم المستخدم: ${user?.displayName ?? 'غير متوفر'}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            ),
            SizedBox(height: 10),
            Text(
              'البريد الإلكتروني: ${user?.email ?? 'غير متوفر'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'رقم الهاتف: ${user?.phoneNumber ?? 'غير متوفر'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
            if (user?.isAnonymous ?? false ? false : true)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.editProfileScreen);
                  },
                  child: Text('تعديل الملف الشخصي'),
                ),
              ),
            SizedBox(height: 20),
            FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final packageInfo = snapshot.data!;
                  return Center(
                    child: Text(
                      'إصدار التطبيق: ${packageInfo.version}',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('تأكيد تسجيل الخروج'),
              content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('تسجيل الخروج'),
                ),
          ],
            );
          },
        )) ??
        false;
  }
}