import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pawmatch/app/modules/onboarding/views/onboarding_view.dart';

class SplashScreenView extends GetView {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.lightBlue,
          Colors.blue,
        ],
      ),
      childWidget: SizedBox(
        height: 100,
        child: Center(
          child: Image.asset(
            'assets/images/splash.png',
          ),
        ),
      ),
      nextScreen: const OnboardingView(),
      animationDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
    );
  }
}
