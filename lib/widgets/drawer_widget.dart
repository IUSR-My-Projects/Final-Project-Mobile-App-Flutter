import 'package:flutter/material.dart';
import 'package:final_project_mobile_app_flutter/screens/routing_screen/routing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCurrentIndex(int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('currentIndex', index);
}

Widget drawerWidget(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Text(
              'تطبيق الصبارة لإدراة المهام',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.green,
          ),
        ),

        // Home screen
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text('الرئيسية'),
            onTap: () {
              saveCurrentIndex(0);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoutingScreen(currentIndex: 0)));
            },
          ),
        ),

        // Projects screen
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Icon(Icons.task),
            title: Text('المشاريع'),
            onTap: () {
              saveCurrentIndex(1);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoutingScreen(currentIndex: 1)));
            },
          ),
        ),

        // Tasks screen
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Icon(Icons.task_alt_outlined),
            title: Text('المهام'),
            onTap: () {
              saveCurrentIndex(2);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoutingScreen(
                            currentIndex: 2,
                          )));
            },
          ),
        ),

        // profile screen
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('الملف الشخصي'),
            onTap: () {
              saveCurrentIndex(3);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoutingScreen(currentIndex: 3)));
            },
          ),
        ),
      ],
    ),
  );
}
