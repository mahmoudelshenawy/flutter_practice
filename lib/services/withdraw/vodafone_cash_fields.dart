import 'package:flutter/material.dart';

class VodafoneCashFields {
  static List<Widget> displayVodafoneCashFields(
      TextEditingController phoneNumber) {
    return [
      TextFormField(
        controller: phoneNumber,
        decoration: const InputDecoration(
          labelText: 'phone number',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add the phone number';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
    ];
  }
}
