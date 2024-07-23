import 'package:flutter/material.dart';
import 'package:final_project_mobile_app_flutter/screens/routing_screen/routing_screen.dart';
import 'package:final_project_mobile_app_flutter/screens/signup_screen/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Provider.of<AuthProvider>(context, listen: false)
              .isUserLoggedIn(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.data == true) {
              return RoutingScreen();
            } else {
              return SignupScreen();
            }
          },
        ),
      ),
    );
  }
}
