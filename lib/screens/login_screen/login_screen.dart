import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project_mobile_app_flutter/widgets/elevated_button_widget.dart';
import 'package:final_project_mobile_app_flutter/widgets/text_field_widget.dart';

import '../../providers/auth_provider.dart';
import '../../routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signup(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Image.asset(
                "assets/icon/logo.png",
                height: 100,
              )),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'انضم إلى تطبيق الصبارة الآن',
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
                height: 50,
              ),
              _login(context),
              const SizedBox(
                height: 20,
              ),
              _loginAnonymously(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return TextFieldWidget(
        label: "البريد الإلكتروني",
        controller: _emailController,
        hintText: 'muhmad@omar.com');
  }

  Widget _password() {
    return TextFieldWidget(
        label: "كلمة المرور",
        controller: _passwordController,
        isPassword: true);
  }

  Widget _login(BuildContext context) {
    return ElevatedButtonWidget(
        context: context,
        label: "تسجيل الدخول",
        onPressed: () async {
          await AuthProvider().login(
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

  Widget _signup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
              text: "مستخدم جديد؟ ",
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            TextSpan(
                text: "إنشاء حساب",
                style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacementNamed(
                        context, Routes.signupScreen);
                  }),
          ])),
    );
  }
}
