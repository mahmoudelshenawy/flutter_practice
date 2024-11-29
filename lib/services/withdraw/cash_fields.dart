import 'package:flutter/material.dart';

class CashFields {
  static List<Widget> displayCashFields(
    TextEditingController fullName,
    TextEditingController phoneNumber,
    TextEditingController country,
    TextEditingController city,
    TextEditingController preference,
  ) {
    return [
      TextFormField(
        controller: fullName,
        decoration: const InputDecoration(
          labelText: 'Full Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add the full name';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: phoneNumber,
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please add the phone number';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: country,
        decoration: const InputDecoration(
          labelText: 'Country',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please add the country';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: city,
        decoration: const InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please add the city';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: preference,
        decoration: const InputDecoration(
          labelText: 'Payment Preference',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please add the payment preference';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
    ];
  }
}
