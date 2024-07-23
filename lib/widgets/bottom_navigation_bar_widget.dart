import 'package:flutter/material.dart';

Widget BottomNavigationBarWidget(
    {required BuildContext context,
    required int currentIndex,
    required Null Function(dynamic index) onTap}) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    backgroundColor: Colors.lightGreenAccent,
    selectedItemColor: Colors.lightGreenAccent,
    unselectedItemColor: Colors.grey,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'الرئيسية',
        tooltip: 'الرئيسية',
        activeIcon: Icon(Icons.home, color: Colors.lightGreenAccent),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.task),
        label: 'المشاريع',
        tooltip: 'المشاريع',
        activeIcon: Icon(Icons.task, color: Colors.lightGreenAccent),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.task_alt),
        label: 'المهام',
        tooltip: 'المهام',
        activeIcon: Icon(Icons.task_alt, color: Colors.lightGreenAccent),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'الملف الشخصي',
        tooltip: 'الملف الشخصي',
        activeIcon: Icon(Icons.person, color: Colors.lightGreenAccent),
      ),
    ],
  );
}
