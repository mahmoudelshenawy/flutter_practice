import 'package:dash/zeus_app/pages/home_page.dart';
import 'package:dash/zeus_app/pages/old_login_page.dart';
import 'package:dash/zeus_app/pages/onboarding_page.dart';
import 'package:dash/zeus_app/pages/splash_screen.dart';
import 'package:dash/zeus_app/pages/wrapper_redirect.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: const Color.fromARGB(255, 4, 114, 204),
          buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            elevation: 2,
            centerTitle: true,
          )
          // colorScheme: ColorScheme.fromSwatch(
          //     primarySwatch: Colors.blue,
          //     backgroundColor: Colors.grey,
          //     cardColor: const Color.fromARGB(255, 255, 255, 255),
          //     accentColor: Colors.amber),
          ),
      home: const SplashScreen(),
      // home: const Scaffold(
      //   body: Center(
      //     child: Text("Hello World"),
      //   ),
      // ),
      // initialRoute: '/index',
      // routes: {
      //   '/index': (context) => WrapperRedirect(),
      //   '/login': (context) => LoginPage(),
      //   '/home': (context) => HomePage(),
      // },
    );
  }
}
