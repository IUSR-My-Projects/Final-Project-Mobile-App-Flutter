import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_project_mobile_app_flutter/routes.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> isUserLoggedIn() async {
    final User? user = auth.currentUser;
    return user != null;
  }

  Future<void> signupAnonymously({required BuildContext context}) async {
    try {
      await auth.signInAnonymously();

      Fluttertoast.showToast(
        msg: 'تم تسجيل الدخول بنجاح',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, Routes.routingScreen);
    } on FirebaseAuthException {
      Fluttertoast.showToast(
        msg: 'حدث خطأ غير معروف',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Fluttertoast.showToast(
        msg: 'تم إنشاء الحساب بنجاح',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacementNamed(context, Routes.routingScreen);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'كلمة المرور المقدمة ضعيفة جدًا.';
      } else if (e.code == 'email-already-in-use') {
        message = 'يوجد حساب بالفعل بهذا البريد الإلكتروني.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ. الرجاء معاودة المحاولة في وقت لاحق.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, Routes.routingScreen);
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'حدث خطأ. الرجاء معاودة المحاولة في وقت لاحق.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> signout({required BuildContext context}) async {
    await auth.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, Routes.signupScreen);
  }
}
