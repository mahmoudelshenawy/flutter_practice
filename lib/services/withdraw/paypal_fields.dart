import 'package:flutter/material.dart';

class PaypalField {
  static List<Widget> displayPaypalFields(
      TextEditingController emailController) {
    return [
      TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'email',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add the email';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
    ];
  }
}
