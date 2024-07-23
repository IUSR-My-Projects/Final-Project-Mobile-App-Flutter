import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_project_mobile_app_flutter/constants/constants.dart';
import 'package:final_project_mobile_app_flutter/models/project_model.dart';
import 'package:final_project_mobile_app_flutter/providers/auth_provider.dart';

class ProjectProvider with ChangeNotifier {
  List<ProjectModel> _projects = [];

  List<ProjectModel> get projects => _projects;

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

  Future<void> addProject(ProjectModel project) async {
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
    final docRef =
        await FirebaseFirestore.instance.collection(projectsName).doc();

    project.id = docRef.id;
    project.userId = userId;

    await docRef.set(project.toMap());

    Fluttertoast.showToast(
      msg: 'تم إضافة المشروع',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    getProjects();
  }

  Future<void> updateProject(ProjectModel project) async {
    await FirebaseFirestore.instance
        .collection(projectsName)
        .doc(project.id)
        .update(project.toMap());

    getProjects();
  }

  Future<void> deleteProject(String projectId) async {
    await FirebaseFirestore.instance
        .collection(projectsName)
        .doc(projectId)
        .delete();

    Fluttertoast.showToast(
      msg: 'تم حذف المشروع',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
    getProjects();
  }
}
