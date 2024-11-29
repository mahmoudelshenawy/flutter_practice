import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final bool emailVerified;
  final DateTime? emailVerifiedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      emailVerified: json["email_verified_at"] != null,
      emailVerifiedAt: json["email_verified_at"] != null
          ? DateTime.parse(json["email_verified_at"])
          : null,
    );
  }
}
