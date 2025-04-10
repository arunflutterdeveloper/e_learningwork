import 'package:e_learning/utill/app_colors.dart';
import 'package:e_learning/view/screen/intro/intro_screen.dart';
import 'package:e_learning/view/screen/signIn/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utill/images_paths.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // final CommonFunctions commonFunctions = CommonFunctions();


  static const String KEYLOGIN = "login";
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // commonFunctions.fetchData();
    // commonFunctions.fetchCheckPlanData();

    // ProfileController().fetchUserData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Animation duration
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward(); // Start the animation

    _navigateBasedOnLoginStatus();
  }

  Future<void> _navigateBasedOnLoginStatus() async {
    var isLoggedIn = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (isLoggedIn) {
        Get.off(() => IntroScreen());
      } else {
        Get.off(() => const SignInScreen());
      }
    });




    // var sharedPref = await SharedPreferences.getInstance();
    // var isLoggedIn = sharedPref.getBool(KEYLOGIN) ?? false;
    // bool? isProfileActive = await commonFunctions.getProfileActive();

    // if (isProfileActive == false && isLoggedIn == true) {
    //   Get.offNamed('/ProfileScreen');
    // } else {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     Navigator.pushReplacement(
    //       context, MaterialPageRoute(
    //       builder: (context) => isLoggedIn ?  DoorHubOnboardingScreen() :  const LoginScreen(),
    //     ),
    //     );
    //   });
    // }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Colors.orange.shade300,
              AppColors.kPrimary,
              AppColors.black6,
              // Colors.orange.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.asset(AppImagePath.E_LOGO),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation(Colors.white30),
                  strokeWidth: 3.0,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ),
              const Positioned(
                bottom: 20,
                child: Text(
                  'E-learning ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
