import 'package:flutter/material.dart';
import 'package:newst_app/core/datasource/preferences_manger.dart';
import 'package:newst_app/features/auth/login_screen.dart';
import 'package:newst_app/features/home/home_screen.dart';
import 'package:newst_app/features/main/main_screen.dart';
import 'package:newst_app/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash()async {

    await Future.delayed(Duration(seconds: 2));

    final bool onboardingComplete =
        PreferencesManger().getBool('onboarding_complete') ?? false;
    final bool isLoggedIn =
        PreferencesManger().getBool('is_logged_in') ?? false;
    if(!mounted) return ;
    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return OnboardingScreen();
          },
        ),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        width: double.infinity,
        'assets/images/splash.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
