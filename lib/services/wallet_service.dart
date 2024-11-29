import 'dart:convert';
import 'package:dash/data/data_local_storage.dart';
import 'package:dash/models/currency.dart';
import 'package:dash/models/payment_method.dart';
import 'package:dash/models/withdraw_confirmation.dart';
import 'package:dash/models/withdraw_form.dart';
import 'package:dash/zeus_app/pages/withdraw_confirmation_page.dart';
import 'package:dash/zeus_app/pages/withdraw_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WalletService {
  static Future<List<PaymentMethod>?> getPaymentMethods() async {
    var token = await getToken();
    var response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/payment_methods"),
      headers: {"Authorization": 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print(response.body);
      var responseJson = json.decode(response.body);
      if (responseJson["success"] == true) {
        List<dynamic> data = responseJson["data"];
        return data.map((json) => PaymentMethod.fromJson(json)).toList();
      } else {
        throw Exception("Something went wrong");
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<List<Currency>?> getCurrencies() async {
    var token = await getToken();
    var response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/currencies"),
      headers: {"Authorization": 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      if (responseJson["success"] == true) {
        List<dynamic> data = responseJson["data"];
        return data.map((json) => Currency.fromJson(json)).toList();
      } else {
        throw Exception("Something went wrong");
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  static Future<void> WithdrawMoney(
      BuildContext context, WithdrawFormMV withdrawForm) async {
    var token = await getToken();
    var response =
        await http.post(Uri.parse("http://127.0.0.1:8000/api/withdraw-money"),
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json",
              "Accept": "application/json"
            },
            body: jsonEncode(withdrawForm.toJson()));
    var responseJson = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 422) {
      if (responseJson['errors'] != null) {
        showErrorDialog(responseJson['errors'], context);
      }
    } else if (response.statusCode == 400 || response.statusCode == 500) {
      if (responseJson["success"] == false && responseJson["error"] != null) {
        showErrorMessageDialog(responseJson["error"], context);
      }
    } else if (response.statusCode == 200) {
      //show alert dialog with
      print("you are good to go");
      String totalFees = responseJson["data"]["total_fees"].toString();
      String totalAmount = responseJson["data"]["total_amount"].toString();

      WithdrawConfirmation model = WithdrawConfirmation(
        amount: withdrawForm.amount.toString(),
        paymentMethodName: withdrawForm.paymentMethodName,
        totalAmount: totalAmount,
        totalFees: totalFees,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WithdrawConfirmationPage(
                    withdrawConfirmation: model,
                  )));
    }
  }

  static Future<void> confirmWithdraw(BuildContext context) async {
    var token = await getToken();
    var response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/confirm-withdraw"),
      headers: {
        "Authorization": 'Bearer $token',
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    );
    var responseJson = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      //print success
      //then redirect to withdrawPage
      showSuccessDialog(context);
    } else {
      //show error
      showErrorMessageDialog(responseJson["error"], context);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WithdrawPage()),
        );
      });
    }
  }

  static void showErrorDialog(
      Map<String, dynamic> errors, BuildContext context) {
    final errorMessages = errors.entries
        .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
        .join('\n');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Validation Errors'),
        content: Text(errorMessages),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showErrorMessageDialog(String error, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Error',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.red[500]),
        ),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Your withdrawal was successful!'),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(), // Allow manual dismissal
            child: const Text('OK'),
          ),
        ],
      ),
    );

    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WithdrawPage()),
      );
    });
  }
}
