import 'package:dash/fitness_dashboard/pages/main_screen.dart';
import 'package:dash/theme/theme_constants.dart';
import 'package:dash/theme/theme_manager.dart';
import 'package:dash/zeus_app/pages/notification_page.dart';
import 'package:dash/zeus_app/pages/products_page.dart';
import 'package:dash/zeus_app/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MainTheme extends StatefulWidget {
  const MainTheme({super.key});

  @override
  State<MainTheme> createState() => _MainThemeState();
}

class _MainThemeState extends State<MainTheme> {
  final ThemeManager _themeManager = ThemeManager();
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(builder: (context, value, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: value.themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        // home: const MainScreen(),
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
        routes: {"/notifications": (context) => const NotificationPage()},
      );
    });
  }
}
