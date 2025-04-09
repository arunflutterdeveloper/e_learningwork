import 'package:e_learning/view/screen/intro/intro_screen.dart';
import 'package:e_learning/view/screen/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-learning',
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}
