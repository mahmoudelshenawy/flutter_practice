import 'package:flutter/material.dart';

class WithdrawFormMV {
  int currency_id;
  int amount;
  int payment_method_id;
  String paymentMethodName;
  VodafoneCashForm? vodafoneCash;
  UsdtForm? usdtForm;
  CashForm? cashForm;
  BankForm? bankForm;
  WithdrawFormMV({
    required this.amount,
    required this.currency_id,
    required this.payment_method_id,
    required this.paymentMethodName,
    this.vodafoneCash,
    this.usdtForm,
    this.cashForm,
    this.bankForm,
  });
  Map<String, dynamic> toJson() {
    return {
      "currency_id": currency_id,
      "amount": amount,
      "payment_method_id": payment_method_id,
      "vodafoneCash": vodafoneCash?.toJson(),
      "usdtForm": usdtForm?.toJson(),
      "cashForm": cashForm?.toJson(),
      "bankForm": bankForm?.toJson(),
    }..removeWhere((key, value) => value == null); // Remove null values
  }
}

class VodafoneCashForm {
  TextEditingController vodafonephoneNumber;
  String get phoneNumber => vodafonephoneNumber.text;
  VodafoneCashForm({required this.vodafonephoneNumber});

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
    };
  }
}

class UsdtForm {
  TextEditingController platformController;
  TextEditingController addressController;
  String get platform => platformController.text;
  String get address => addressController.text;
  UsdtForm({
    required this.platformController,
    required this.addressController,
  });

  Map<String, dynamic> toJson() {
    return {
      "platform": platform,
      "address": address,
    };
  }
}

class CashForm {
  TextEditingController fullNameController;
  TextEditingController phoneNumberController;
  TextEditingController countryController;
  TextEditingController cityController;
  TextEditingController preferenceController;

  String get fullName => fullNameController.text;
  String get phoneNumber => phoneNumberController.text;
  String get country => countryController.text;
  String get city => cityController.text;
  String get preference => preferenceController.text;

  CashForm({
    required this.fullNameController,
    required this.phoneNumberController,
    required this.countryController,
    required this.cityController,
    required this.preferenceController,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "country": country,
      "city": city,
      "preference": preference,
    };
  }
}

class BankForm {
  TextEditingController accountHolderNameController;
  TextEditingController ibanController;
  TextEditingController swiftCodeController;
  TextEditingController bankNameController;
  TextEditingController branchNameController;
  TextEditingController branchCityController;
  TextEditingController branchAddressController;
  TextEditingController countryController;
  String get accountHolderName => accountHolderNameController.text;
  String get iban => ibanController.text;
  String get swiftCode => swiftCodeController.text;
  String get bankName => bankNameController.text;
  String get branchName => branchNameController.text;
  String get branchCity => branchCityController.text;
  String get branchAddress => branchAddressController.text;
  String get country => countryController.text;

  BankForm({
    required this.accountHolderNameController,
    required this.bankNameController,
    required this.branchAddressController,
    required this.branchCityController,
    required this.branchNameController,
    required this.countryController,
    required this.ibanController,
    required this.swiftCodeController,
  });

  Map<String, dynamic> toJson() {
    return {
      "accountHolderName": accountHolderName,
      "iban": iban,
      "swiftCode": swiftCode,
      "bankName": bankName,
      "branchName": branchName,
      "branchCity": branchCity,
      "branchAddress": branchAddress,
      "country": country,
    };
  }
}
