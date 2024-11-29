import 'package:dash/models/currency.dart';
import 'package:dash/models/deposit_form.dart';
import 'package:dash/models/payment_method.dart';
import 'package:dash/services/deposit_service.dart';
import 'package:dash/zeus_app/pages/deposit_vodafone_cash.dart';
import 'package:flutter/material.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  List<PaymentMethod> paymentMethods = [];
  List<Currency> currencies = [];
  Currency? selectedCurrency;
  PaymentMethod? selectedPaymentMethod;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  DepositForm? depositForm;
  //
  bool isLoading = false;
  bool showFeesInfo = false;
  String feesInfoMsg = "";
  bool showErrorInfo = false;
  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  Future<void> getCurrencies() async {
    var currenciesList = await DepositService.getCurrencies();
    if (currenciesList != null && currenciesList.isNotEmpty) {
      setState(() {
        currencies = currenciesList;
        selectedCurrency = currencies.first;
      });
      //getpaymentmethods
      var paymentMethodsList =
          await DepositService.getPaymentMethods(selectedCurrency!.id);
      if (paymentMethodsList != null && paymentMethodsList.isNotEmpty) {
        setState(() {
          paymentMethods = paymentMethodsList;
          selectedPaymentMethod = paymentMethodsList.first;
        });
      }
    }
  }

  Future<void> currencyChange() async {
    if (selectedCurrency != null) {
      var paymentMethodsList =
          await DepositService.getPaymentMethods(selectedCurrency!.id);
      if (paymentMethodsList != null && paymentMethodsList.isNotEmpty) {
        setState(() {
          paymentMethods = paymentMethodsList;
          selectedPaymentMethod = paymentMethodsList.first;
        });
      }
    }
  }

//listen on changes in currency, paymentmethod and amount
  Future<void> checkChangesInDataInputs() async {
    setState(() {
      isLoading = true;
    });
    if (selectedCurrency != null &&
        selectedPaymentMethod != null &&
        _amountController.text.isNotEmpty) {
      //get fees and limits
      DepositForm form = DepositForm(
          amount: double.parse(_amountController.text),
          currencyId: selectedCurrency!.id,
          paymentMethodId: selectedPaymentMethod!.id,
          methodName: selectedPaymentMethod!.name);
      depositForm = form;
      var response = await DepositService.checkAmountFeesLimit(form, context);
      if (response.errorMsg != null) {
        setState(() {
          feesInfoMsg = "";
          errorMsg = response.errorMsg!;
          showErrorInfo = true;
          showFeesInfo = false;
        });
      }
      if (response.totalFees != null) {
        setState(() {
          feesInfoMsg =
              "percent charge ${response.percentCharge} and fixed cha+rge ${response.fixedCharge} (of total fees ${response.totalFees})";
          errorMsg = "";
          showErrorInfo = false;
          showFeesInfo = true;
        });
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deposit"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        onChanged: (newValue) async {
                          setState(() {
                            selectedCurrency = newValue!;
                          });
                          await currencyChange();
                          await checkChangesInDataInputs();
                        },
                        decoration: const InputDecoration(
                          labelText: 'Currency',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a currency' : null,
                      ),
                const SizedBox(height: 16),
                // PaymentMethods Dropdown
                paymentMethods.isEmpty
                    ? const CircularProgressIndicator()
                    : DropdownButtonFormField<PaymentMethod>(
                        value: selectedPaymentMethod,
                        items: paymentMethods.map((paymentMethod) {
                          return DropdownMenuItem<PaymentMethod>(
                            value: paymentMethod,
                            child: Text(paymentMethod.name),
                          );
                        }).toList(),
                        onChanged: (newValue) async {
                          setState(() {
                            selectedPaymentMethod = newValue!;
                          });
                          await checkChangesInDataInputs();
                        },
                        decoration: const InputDecoration(
                          labelText: 'Payment Method',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null
                            ? 'Please select a payment method'
                            : null,
                      ),
                const SizedBox(
                  height: 18,
                ),
                // Amount TextField
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  onEditingComplete: () async {
                    await checkChangesInDataInputs();
                  },
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
                Visibility(
                  visible: showFeesInfo,
                  child: Text(
                    feesInfoMsg,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),

                Visibility(
                  visible: showErrorInfo,
                  child: Text(
                    errorMsg,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.red[600], fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: isLoading || showErrorInfo
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              // Handle form submission
                              if (selectedPaymentMethod!.name ==
                                  "VodafoneCash") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DepositVodafoneCash(
                                              depositForm: depositForm!,
                                            )));
                              }
                            }
                            //submit to complete
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: isLoading,
                          child: const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('Submit')
                      ],
                    ),
                  ),
                ),
                // Submit Button

                const SizedBox(height: 10),
              ],
            ),
          )),
    );
  }
}
