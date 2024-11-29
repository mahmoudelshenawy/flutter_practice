import 'dart:convert';

import 'package:dash/apis/pusher_config.dart';
import 'package:dash/data/data_local_storage.dart';
import 'package:dash/fitness_dashboard/pages/main_screen.dart';
import 'package:dash/models/user.dart';
import 'package:dash/services/auth_service.dart';
import 'package:dash/theme/theme_manager.dart';
import 'package:dash/zeus_app/pages/chat_page.dart';
import 'package:dash/zeus_app/pages/login_page.dart';
import 'package:dash/zeus_app/pages/posts_page.dart';
import 'package:dash/zeus_app/pages/products_page.dart';
import 'package:dash/zeus_app/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PusherConfig pusherConfig;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();

    pusherConfig = PusherConfig();

    pusherConfig.initPusher(
      onEvent,
    );
  }

  void onEvent(PusherEvent event) {
    print("event came: " + event.data.toString());
    print(jsonDecode(event.data)["message"]);
    try {
      if (event.eventName.toString() == "App\\Events\\NotifyAdmin") {
        print("this is special print");
      }
      print(event.eventName.toString());
    } catch (e) {
      print(e);
    }
  }

  final ThemeManager _themeManager = ThemeManager();
  Future<void> _checkAuthStatus() async {
    var isAuth = await AuthService.isAuth();
    print("from home page ${isAuth}");
    if (!isAuth) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  // This method returns a FutureBuilder that calls `getUser`
  Widget buildUserData() {
    return FutureBuilder<User?>(
      future: AuthService.getUser(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        // Handle loading, error, and success states
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data != null) {
          User user = snapshot.data!;
          // Display user information
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ID: ${user.id}"),
              Text("Name: ${user.name}"),
              Text("Email: ${user.email}"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsPage()),
                  );
                },
                child: const Text("Go To Products"),
              )
            ],
          );
        } else {
          return const Text("User data not available");
        }
      },
    );
  }

  Widget addVerticalSpace(double? height) {
    return SizedBox(
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme App"),
        actions: [
          Consumer<ThemeManager>(builder: (context, value, child) {
            return Switch(
                value: value.themeMode == ThemeMode.dark,
                // value: _themeManager.themeMode == ThemeMode.dark,
                onChanged: (newValue) {
                  // _themeManager.toggleTheme(newValue);
                  Provider.of<ThemeManager>(context, listen: false)
                      .toggleTheme(newValue);
                });
          })
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/images/profile_pic.png",
                  width: 200,
                  height: 200,
                ),
                addVerticalSpace(10),
                Text(
                  "Your Name",
                  style: _textTheme.headlineMedium?.copyWith(
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(10),
                Text(
                  "@yourusername",
                  style: _textTheme.titleMedium,
                ),
                addVerticalSpace(10),
                const Text(
                  "This is a simple Status",
                ),
                addVerticalSpace(20),
                const TextField(),
                addVerticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: const Text("products"),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductsPage()));
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      child: const Text("my wallet"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WalletPage()));
                      },
                    ),
                  ],
                ),
                addVerticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text("posts"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostsPage()));
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      child: const Text("Fitness Dashboard"),
                      onPressed: () {
                        Provider.of<ThemeManager>(context, listen: false)
                            .toggleTheme(true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()));
                      },
                    ),
                  ],
                ),
                addVerticalSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text("Chat UI"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatPage()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.blue), // For Test
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
