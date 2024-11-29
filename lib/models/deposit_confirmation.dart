import 'dart:io';

class DepositConfirmation {
  int currencyId;
  int paymentMethodId;
  double amount;
  File? file;

  DepositConfirmation(
      {required this.amount,
      required this.currencyId,
      required this.paymentMethodId,
      this.file});

  Map<String, dynamic> toJson() {
    return {
      "currency_id": currencyId,
      "amount": amount,
      "payment_method_id": paymentMethodId,
    };
  }
}
