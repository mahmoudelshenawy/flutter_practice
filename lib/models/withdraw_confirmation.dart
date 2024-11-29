class WithdrawConfirmation {
  String totalFees;
  String totalAmount;
  String amount;
  String paymentMethodName;

  WithdrawConfirmation({
    required this.amount,
    required this.paymentMethodName,
    required this.totalAmount,
    required this.totalFees,
  });
}
