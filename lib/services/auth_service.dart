import 'dart:convert';
import 'package:dash/data/data_local_storage.dart';
import 'package:dash/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthService {
  static bool _isLoggedIn = false;

  static bool get isLoggedIn => _isLoggedIn;

  static Future<bool> login(String email, String password) async {
    // Here you would add real login logic
    var response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/login"),
      body: {"email": email, "password": password},
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      if (responseJson["success"] == true) {
        storeToken(responseJson["access_token"]);
        storeTokenExpiryDate(responseJson["expires_in_date_time"]);
        _isLoggedIn = true;
        return true;
      }
    } else {
      //alert with error
    }
    return false;
  }

  static Future<User?> getUser() async {
    var token = await getToken();
    if (token == null) {
      return null;
    }
    var response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/user"),
      headers: {"Authorization": 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      if (responseJson["success"] == true) {
        var user = User(
          id: responseJson["user"]["id"],
          name: responseJson["user"]["name"],
          email: responseJson["user"]["email"],
          emailVerifiedAt: responseJson["user"]["email_verified_at"],
          emailVerified: true,
        );
        return user;
      }
    }
    return null;
  }

  static Future<void> logout() async {
    _isLoggedIn = false;
    await deleteToken();
    await deleteTokenExpiryDate();
  }

  static Future<bool> isAuth() async {
    var token = await getToken();
    var expiresIn = await getTokenExpiryDate();
    if (token == null) {
      return false;
    }
    DateTime currentDate = DateTime.now();
    String dateTimeString = expiresIn!;
    DateTime givenDate = DateTime.parse(dateTimeString);
    return givenDate.isAfter(currentDate);
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
