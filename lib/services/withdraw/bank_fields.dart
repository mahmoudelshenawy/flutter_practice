import 'package:flutter/material.dart';

class BankFields {
  static List<Widget> displayBankFields(
    TextEditingController accountHolderName,
    TextEditingController iban,
    TextEditingController swiftCode,
    TextEditingController bankName,
    TextEditingController branchName,
    TextEditingController branchCity,
    TextEditingController branchAddress,
    TextEditingController country,
  ) {
    return [
      TextFormField(
        controller: accountHolderName,
        decoration: const InputDecoration(
          labelText: 'account holder name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add the account holder name';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: iban,
        decoration: const InputDecoration(
          labelText: 'IBAN',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add IBAN';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: swiftCode,
        decoration: const InputDecoration(
          labelText: 'Swift Code',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add the Swift Code';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: bankName,
        decoration: const InputDecoration(
          labelText: 'Bank Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add bank name';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: branchName,
        decoration: const InputDecoration(
          labelText: 'brach name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add branch name';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: branchCity,
        decoration: const InputDecoration(
          labelText: 'branch city',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please add branch city';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: branchAddress,
        decoration: const InputDecoration(
          labelText: 'branch address',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please branch city';
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
            return 'please add the Country';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
    ];
  }
}
