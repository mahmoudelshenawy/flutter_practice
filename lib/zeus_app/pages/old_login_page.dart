import 'package:dash/data/data_local_storage.dart';
import 'package:dash/services/auth_service.dart';
import 'package:dash/zeus_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class OldLoginPage extends StatefulWidget {
  OldLoginPage({super.key});

  @override
  State<OldLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<OldLoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    var user = await AuthService.getUser();
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 70, horizontal: 12),
                child: Card(
                  margin: const EdgeInsets.only(top: 30),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12, right: 15, left: 15, bottom: 12),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Image.asset(
                              "lib/images/logo2.png",
                              height: 120,
                            ),
                            // const Text(
                            //   "Login",
                            //   style: TextStyle(
                            //       fontSize: 19, fontWeight: FontWeight.bold),
                            // ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "email",
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                hintText: "password",
                                labelText: "Password",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool result = await AuthService.login(
                                      emailController.text,
                                      passwordController.text);
                                  if (result) {
                                    Navigator.pushReplacementNamed(
                                        context, "/home");
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Login failed, please try again")),
                                  );
                                }
                              },
                              child: const Text("Login"),
                            ),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
