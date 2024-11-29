import 'package:dash/models/currency.dart';
import 'package:dash/models/withdraw_form.dart';
import 'package:dash/services/wallet_service.dart';
import 'package:dash/services/withdraw/bank_fields.dart';
import 'package:dash/services/withdraw/cash_fields.dart';
import 'package:dash/services/withdraw/paypal_fields.dart';
import 'package:dash/services/withdraw/usdt_fields.dart';
import 'package:dash/services/withdraw/vodafone_cash_fields.dart';
import 'package:flutter/material.dart';

class WithdrawForm extends StatefulWidget {
  final String methodName;
  final int paymentMethodId;
  final BuildContext parentContext;
  const WithdrawForm(
      {super.key,
      required this.methodName,
      required this.paymentMethodId,
      required this.parentContext});
  @override
  State<WithdrawForm> createState() => _WithdrawFormState();
}

class _WithdrawFormState extends State<WithdrawForm> {
  final _formKey = GlobalKey<FormState>();

  Currency? selectedCurrency;

  //vodafone cash fields
  final TextEditingController vodafonephoneNumber = TextEditingController();
  //bank fields
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController iban = TextEditingController();
  final TextEditingController swiftCode = TextEditingController();
  final TextEditingController bankName = TextEditingController();
  final TextEditingController branchName = TextEditingController();
  final TextEditingController branchCity = TextEditingController();
  final TextEditingController branchAddress = TextEditingController();
  final TextEditingController bankCountry = TextEditingController();
  //usdt fields
  final TextEditingController platformController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  //cash fields
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController cashCountry = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController preference = TextEditingController();
  //paypal fields
  final emailController = TextEditingController();
  //
  final TextEditingController _amountController = TextEditingController();
  List<Currency> currencies = [];
  WithdrawFormMV? withdrawFormMV;
  VodafoneCashForm? vodafoneCashForm;
  UsdtForm? usdtForm;
  CashForm? cashForm;
  BankForm? bankForm;

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  Future<void> getCurrencies() async {
    var currenciesList = await WalletService.getCurrencies();
    if (currenciesList != null && currenciesList.isNotEmpty) {
      setState(() {
        currencies = currenciesList;
        selectedCurrency = currencies.first;
      });
    }
  }

  List<Widget> _buildFields() {
    switch (widget.methodName) {
      case "VodafoneCash":
        vodafoneCashForm =
            VodafoneCashForm(vodafonephoneNumber: vodafonephoneNumber);
        return VodafoneCashFields.displayVodafoneCashFields(
            vodafonephoneNumber);
      case "Usdt":
        usdtForm = UsdtForm(
          platformController: platformController,
          addressController: addressController,
        );
        return UsdtFields.displayUsdtFields(
            platformController, addressController);
      case "Bank":
        bankForm = BankForm(
          accountHolderNameController: accountHolderName,
          bankNameController: bankName,
          branchAddressController: branchAddress,
          branchCityController: branchCity,
          branchNameController: branchName,
          countryController: bankCountry,
          ibanController: iban,
          swiftCodeController: swiftCode,
        );
        return BankFields.displayBankFields(accountHolderName, iban, swiftCode,
            bankName, branchName, branchCity, branchAddress, bankCountry);
      case "Paypal":
        return PaypalField.displayPaypalFields(emailController);
      case "Cash":
        cashForm = CashForm(
          fullNameController: fullName,
          phoneNumberController: phoneNumber,
          countryController: cashCountry,
          cityController: city,
          preferenceController: preference,
        );
        return CashFields.displayCashFields(
            fullName, phoneNumber, cashCountry, city, preference);
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Currency Dropdown
          currencies.isEmpty
              ? const CircularProgressIndicator()
              : DropdownButtonFormField<Currency>(
                  value: selectedCurrency,
                  items: currencies.map((currency) {
                    return DropdownMenuItem<Currency>(
                      value: currency,
                      child: Text(currency.code),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCurrency = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Currency',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null ? 'Please select a currency' : null,
                ),
          const SizedBox(height: 16),

          // Amount TextField
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ..._buildFields(),
          const SizedBox(height: 20),
          // Submit Button
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Handle form submission
                Navigator.pop(context); // Close the bottom sheet
              }
              withdrawFormMV = WithdrawFormMV(
                  amount: int.parse(_amountController.text),
                  currency_id: 1,
                  payment_method_id: widget.paymentMethodId,
                  paymentMethodName: widget.methodName,
                  vodafoneCash: vodafoneCashForm,
                  usdtForm: usdtForm,
                  bankForm: bankForm,
                  cashForm: cashForm);
              await WalletService.WithdrawMoney(
                  widget.parentContext, withdrawFormMV!);
            },
            child: const Text('Submit'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
