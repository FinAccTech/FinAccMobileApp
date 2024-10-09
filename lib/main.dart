import 'package:finacc/screens/splash.dart';
import 'package:flutter/material.dart';

import 'config/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: Splash.routeName,
    );
  }
}
