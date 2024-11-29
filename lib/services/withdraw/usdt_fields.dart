import 'package:flutter/material.dart';

class UsdtFields {
  static List<Widget> displayUsdtFields(
      TextEditingController platformController,
      TextEditingController addressController) {
    return [
      TextFormField(
        controller: platformController,
        decoration: const InputDecoration(
          labelText: 'Platform',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add the platform';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: addressController,
        decoration: const InputDecoration(
          labelText: 'Wallet Address',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your wallet address';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
    ];
  }
}
