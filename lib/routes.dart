import 'package:flutter/cupertino.dart';
import 'package:final_project_mobile_app_flutter/models/task_model.dart';
import 'package:final_project_mobile_app_flutter/screens/auth_screen/auth_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/home_screen/home_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/login_screen/login_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/profile_screen/edit_profile_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/profile_screen/profile_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/project_screen/add_project_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/project_screen/project_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/routing_screen/routing_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/signup_screen/signup_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/task_screen/add_task_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/task_screen/edit_task_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/task_screen/task_details_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/task_screen/task_screen.dart';

class Routes {
  Routes._();

  static const String loginScreen = '/login-screen';
  static const String signupScreen = '/signup-screen';
  static const String homeScreen = '/home-screen';
  static const String authScreen = '/auth-screen';
  static const String profileScreen = '/profile-screen';
  static const String editProfileScreen = '/edit-profile-screen';
  static const String projectScreen = '/project-screen';
  static const String projectDetailsScreen = '/project-details-screen';
  static const String editProjectScreen = '/edit-project-screen';
  static const String addProjectScreen = '/add-project-screen';
  static const String taskScreen = '/task-screen';
  static const String taskDetailsScreen = '/task-details-screen';
  static const String editTaskScreen = '/edit-task-screen';
  static const String routingScreen = '/routing-screen';
  static const String addTaskScreen = '/add-task-screen';

  static final dynamic routes = <String, WidgetBuilder>{
    Routes.loginScreen: (BuildContext context) => LoginScreen(),
    Routes.signupScreen: (BuildContext context) => SignupScreen(),
    Routes.homeScreen: (BuildContext context) => HomeScreen(),
    Routes.authScreen: (BuildContext context) => AuthScreen(),
    Routes.profileScreen: (BuildContext context) => ProfileScreen(),
    Routes.editProfileScreen: (BuildContext context) => EditProfileScreen(),
    Routes.projectScreen: (BuildContext context) => ProjectScreen(),
    Routes.taskScreen: (BuildContext context) => TaskScreen(),
    Routes.routingScreen: (BuildContext context) => RoutingScreen(),
    Routes.addTaskScreen: (BuildContext context) => AddTaskScreen(),
    // Routes.projectDetailsScreen: (BuildContext context) =>
    //     ProjectDetailsScreen(project: null,),
    // Routes.editProjectScreen: (BuildContext context) => EditProjectScreen(project: null,),
    Routes.addProjectScreen: (BuildContext context) => AddProjectScreen(),
    Routes.taskDetailsScreen: (BuildContext context) => TaskDetailsScreen(
          task: new TaskModel(
              id: "",
              projectId: '',
              title: '',
              description: '',
              status: TaskStatus.start,
              priority: true,
              createdAt: DateTime.now()),
        ),
    Routes.editTaskScreen: (BuildContext context) => EditTaskScreen(
          task: new TaskModel(
              id: "",
              projectId: '',
              title: '',
              description: '',
              status: TaskStatus.start,
              priority: true,
              createdAt: DateTime.now()),
        ),
  };
}
