import 'package:final_project_mobile_app_flutter/providers/auth_provider.dart';
import 'package:final_project_mobile_app_flutter/providers/project_provider.dart';
import 'package:final_project_mobile_app_flutter/providers/task_provider.dart';
import 'package:final_project_mobile_app_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Providers {
  Providers._();

  static final providers = [
    // Auth Provider
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider<TaskProvider>(
      create: (context) => TaskProvider(),
    ),
    ChangeNotifierProvider<ProjectProvider>(
      create: (context) => ProjectProvider(),
    ), // End Project Provider
  ].toList();
}
