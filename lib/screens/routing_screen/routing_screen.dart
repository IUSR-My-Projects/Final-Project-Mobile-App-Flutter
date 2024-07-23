import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/drawer_widget.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../project_screen/project_screen.dart';
import '../task_screen/task_screen.dart';

class RoutingScreen extends StatefulWidget {
  int currentIndex;

  RoutingScreen({super.key, this.currentIndex = 0});

  @override
  State<RoutingScreen> createState() => _RoutingScreenState();
}

class _RoutingScreenState extends State<RoutingScreen> {
  @override
  void initState() {
    super.initState();
    _loadCurrentIndex();
  }

  Future<void> _loadCurrentIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.currentIndex = prefs.getInt('currentIndex') ?? 0;
    });
  }

  Future<void> _saveCurrentIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentIndex', index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(),
      drawer: drawerWidget(context),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
            _saveCurrentIndex(index);
          });
        },
        context: context,
      ),
    );
  }

  Widget _buildBody() {
    switch (widget.currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return ProjectScreen();
      case 2:
        return TaskScreen();
      case 3:
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }
}
