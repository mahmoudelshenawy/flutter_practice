import 'package:dash/services/auth_service.dart';
import 'package:dash/zeus_app/pages/home_page.dart';
import 'package:dash/zeus_app/pages/login_page.dart';
import 'package:dash/zeus_app/pages/old_login_page.dart';
import 'package:dash/zeus_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:dash/data/data_local_storage.dart';

class WrapperRedirect extends StatefulWidget {
  WrapperRedirect({super.key});

  @override
  State<WrapperRedirect> createState() => _WrapperRedirectState();
}

class _WrapperRedirectState extends State<WrapperRedirect> {
  @override
  void initState() {
    super.initState();
    // _checkAuthUser();
  }

  void _checkAuthUser() async {
    var bool = await checkIfAppInstall();
    if (!bool) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    }
    var isAuth = await AuthService.isAuth();
    if (isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthService.isLoggedIn ? const HomePage() : LoginPage();
  }
}
