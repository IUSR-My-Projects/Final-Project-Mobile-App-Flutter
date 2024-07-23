import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:final_project_mobile_app_flutter/providers.dart';
import 'package:final_project_mobile_app_flutter/routes.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: Providers.providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
      ],
      locale: Locale("ar", "AE"),
      debugShowCheckedModeBanner: false,
      title: 'Cactus Management Tasks',
      initialRoute: Routes.authScreen,
      routes: Routes.routes,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black54,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black54,
          iconTheme: IconThemeData(color: Colors.white70),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black54,
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
