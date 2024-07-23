import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_project_mobile_app_flutter/constants/constants.dart';

import '../models/project_model.dart';
import '../models/task_model.dart';
import 'auth_provider.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<ProjectModel> _projects = [];

  List<TaskModel> get tasks => _tasks;

  Future<void> getTasks() async {
    String? userId = AuthProvider().auth.currentUser?.uid;

    final querySnapshot = await FirebaseFirestore.instance
        .collection(tasksName)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    _tasks =
        querySnapshot.docs.map((doc) => TaskModel.fromMap(doc.data())).toList();

    notifyListeners();
  }

  Future<void> getTasksByProjectId(String projectId) async {
    String? userId = AuthProvider().auth.currentUser?.uid;

    final querySnapshot = await FirebaseFirestore.instance
        .collection(tasksName)
        .where('userId', isEqualTo: userId)
        .where('projectId', isEqualTo: projectId)
        .orderBy('createdAt', descending: true)
        .get();

    _tasks =
        querySnapshot.docs.map((doc) => TaskModel.fromMap(doc.data())).toList();

    notifyListeners();
  }

  Future<void> getProjects() async {
    String? userId = AuthProvider().auth.currentUser?.uid;

    final querySnapshot = await FirebaseFirestore.instance
        .collection(projectsName)
        .where('userId', isEqualTo: userId)
        .get();
    _projects = querySnapshot.docs
        .map((doc) => ProjectModel.fromMap(doc.data()))
        .toList();
    notifyListeners();
  }

  String getProjectNameById(String projectId) {
    final project = _projects.firstWhere((project) => project.id == projectId,
        orElse: () => ProjectModel(
            id: '',
            name: 'غير معروف',
            description: '',
            createdAt: DateTime.now()));
    return project.name;
  }

  Future<void> addTask(TaskModel task) async {
    String? userId = AuthProvider().auth.currentUser?.uid;
    if (userId == null) {
      Fluttertoast.showToast(
        msg: 'تعذر الحصول على معرف المستخدم',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return;
    }

    final docRef = await FirebaseFirestore.instance.collection(tasksName).doc();

    task.id = docRef.id;
    task.userId = userId;
    await docRef.set(task.toMap());

    Fluttertoast.showToast(
      msg: 'تم إضافة المهمة',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    await FirebaseFirestore.instance
        .collection(tasksName)
        .doc(task.id)
        .update(task.toMap());

    Fluttertoast.showToast(
      msg: 'تم تحديث المهمة',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    String? userId = AuthProvider().auth.currentUser?.uid;
    if (userId == null) {
      Fluttertoast.showToast(
        msg: 'تعذر الحصول على معرف المستخدم',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return;
    }

    final docSnapshot = await FirebaseFirestore.instance
        .collection(tasksName)
        .doc(taskId)
        .get();
    if (docSnapshot.exists && docSnapshot.data()?['userId'] == userId) {
      await FirebaseFirestore.instance
          .collection(tasksName)
          .doc(taskId)
          .delete();

      Fluttertoast.showToast(
        msg: 'تم حذف المهمة',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg: 'ليس لديك إذن لحذف هذه المهمة',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
