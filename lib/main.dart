import 'package:dash/apis/firebase_api.dart';
import 'package:dash/apis/pusher_service.dart';
import 'package:dash/data/cart_model.dart';
import 'package:dash/firebase_options.dart';
import 'package:dash/theme/theme_manager.dart';
import 'package:dash/zeus_app/main_app.dart';
import 'package:dash/zeus_app/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//adb reverse tcp:8000 tcp:8000
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  // PusherService pusherService = PusherService();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartModel()),
      ChangeNotifierProvider(create: (_) => ThemeManager()),
    ],
    child: const MainTheme(),
  ));
}
