import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

// Store JWT token securely
Future<void> storeToken(String token) async {
  await storage.write(key: "jwt_token", value: token);
}

// Store Expires_At
Future<void> storeTokenExpiryDate(String datetime) async {
  await storage.write(key: "jwt_token_expiry_date", value: datetime);
}

// Retrieve JWT token
Future<String?> getToken() async {
  return await storage.read(key: "jwt_token");
}

// Retrieve JWT token Expiry Date
Future<String?> getTokenExpiryDate() async {
  return await storage.read(key: "jwt_token_expiry_date");
}

// Delete JWT token (on logout)
Future<void> deleteToken() async {
  await storage.delete(key: "jwt_token");
}

// Delete JWT token Expiry Date(on logout)
Future<void> deleteTokenExpiryDate() async {
  await storage.delete(key: "jwt_token_expiry_date");
}

Future<void> storeAppInstalled() async {
  await storage.write(key: "app_installed", value: "1");
}

Future<bool> checkIfAppInstall() async {
  var appInstalled = await storage.read(key: "app_installed");
  if (appInstalled == null) {
    await storeAppInstalled();
  }
  return appInstalled != null && appInstalled == "1";
}
