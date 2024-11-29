class DepositForm {
  int currencyId;
  int paymentMethodId;
  double amount;

  //response data
  String? methodName;
  String? percentCharge;
  String? fixedCharge;
  String? errorMsg;
  String? totalFees;
  String? totalAmount;

  DepositForm(
      {required this.amount,
      required this.currencyId,
      required this.paymentMethodId,
      this.errorMsg,
      this.fixedCharge,
      this.percentCharge,
      this.totalAmount,
      this.totalFees,
      this.methodName});

  Map<String, dynamic> toJson() {
    return {
      "currency_id": currencyId,
      "amount": amount,
      "payment_method_id": paymentMethodId,
    };
  }
}
