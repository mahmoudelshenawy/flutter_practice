import 'dart:async';
import 'package:dash/data/data_local_storage.dart';
import 'package:dash/services/auth_service.dart';
import 'package:dash/zeus_app/components/onboarding_card.dart';
import 'package:dash/zeus_app/pages/home_page.dart';
import 'package:dash/zeus_app/pages/login_page.dart';
import 'package:dash/zeus_app/pages/old_login_page.dart';
import 'package:dash/zeus_app/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedPositioned(
              top: animate ? 0 : -40,
              left: animate ? 0 : -40,
              duration: const Duration(milliseconds: 1200),
              child: Image.asset(
                "lib/images/avocado.png",
                height: 80,
              ),
            ),
            AnimatedPositioned(
              top: 80,
              left: animate ? 30 : -80,
              duration: const Duration(milliseconds: 1200),
              child: AnimatedOpacity(
                opacity: animate ? 1 : 0,
                duration: const Duration(milliseconds: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bankera",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Text(
                      "Invest safely with us",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: animate ? 150 : -100,
              duration: const Duration(milliseconds: 1200),
              child: Image.asset(
                "lib/images/logo2.png",
                width: 410,
              ),
            ),
            AnimatedPositioned(
              bottom: 40,
              right: animate ? 20 : -25,
              duration: const Duration(milliseconds: 1200),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.yellow[400],
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    var appInstalled = await checkIfAppInstall();
    print("the app installed ${appInstalled}");
    if (appInstalled) {
      //check is auth
      var isAuth = await AuthService.isAuth();
      if (isAuth) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OnboardingPage()));
    }
  }
}
