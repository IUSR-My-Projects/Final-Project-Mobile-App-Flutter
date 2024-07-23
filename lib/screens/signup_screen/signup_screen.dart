import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project_mobile_app_flutter/routes.dart';
import 'package:final_project_mobile_app_flutter/widgets/elevated_button_widget.dart';
import 'package:final_project_mobile_app_flutter/widgets/text_field_widget.dart';

import '../../providers/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: _signin(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 50,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  "assets/icon/logo.png",
                  height: 100,
                )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'سجل ضمن إدراة الصبارة',
                    style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                _emailAddress(),
                const SizedBox(
                  height: 20,
                ),
                _password(),
                const SizedBox(
                  height: 30,
                ),
                _signup(context),
                const SizedBox(
                  height: 20,
                ),
                _loginAnonymously(context)
              ],
            ),
          ),
        ));
  }

  Widget _emailAddress() {
    return TextFieldWidget(
        label: "البريد الإلكتروني",
        controller: _emailController,
        hintText: "muhmad@omar.com");
  }

  Widget _password() {
    return TextFieldWidget(
        label: "كلمة المرور",
        controller: _passwordController,
        isPassword: true);
  }

  Widget _signup(BuildContext context) {
    return ElevatedButtonWidget(
        context: context,
        label: "إنشاء حساب جديد",
        onPressed: () async {
          await AuthProvider().signup(
              email: _emailController.text,
              password: _passwordController.text,
              context: context);
        });
  }

  Widget _loginAnonymously(BuildContext context) {
    return ElevatedButtonWidget(
        context: context,
        label: "سجل بشكل مجهول",
        onPressed: () async {
          await AuthProvider().signupAnonymously(context: context);
        });
  }

  Widget _signin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
              text: "هل لديك حساب بالفعل؟ ",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            TextSpan(
                text: "تسجيل الدخول",
                style: const TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacementNamed(context, Routes.loginScreen);
                  }),
          ])),
    );
  }
}
