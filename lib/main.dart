import 'package:e_learning/view/screen/Home/Dashboard/dashboard_screen.dart';
import 'package:e_learning/view/screen/SignUp/sign_up_screen.dart';
import 'package:e_learning/view/screen/intro/intro_screen.dart';
import 'package:e_learning/view/screen/signIn/sign_in_screen.dart';
import 'package:e_learning/view/screen/splash/splash_screen.dart';
import 'package:e_learning/view/screen/try/ChatAiScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-learning',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',

      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/intro', page: () => IntroScreen()),
        GetPage(name: '/SignIn', page: () => SignInScreen()),
        GetPage(name: '/SignUp', page: () => SignUpScreen()),
        GetPage(name: '/ChatScreen', page: () => ChatScreen()),
        GetPage(name: '/DashBoard', page: () => DashboardScreen()),
      ],
    );
  }
}
