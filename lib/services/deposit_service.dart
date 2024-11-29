import 'dart:convert';
import 'package:dash/data/data_local_storage.dart';
import 'package:dash/models/currency.dart';
import 'package:dash/models/deposit_confirmation.dart';
import 'package:dash/models/deposit_form.dart';
import 'package:dash/models/payment_method.dart';
import 'package:dash/models/vodafone_cash.dart';
import 'package:dash/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepositService {
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

  //getpaymentmethods of currency
  static Future<List<PaymentMethod>?> getPaymentMethods(int currencyId) async {
    var token = await getToken();
    var response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/currency-payment-methods"),
        headers: {
          "Authorization": 'Bearer $token',
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode({"currency_id": currencyId}));
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

  static Future<DepositForm> checkAmountFeesLimit(
      DepositForm depositForm, BuildContext context) async {
    try {
      var token = await getToken();
      var response = await http.post(
          Uri.parse("http://127.0.0.1:8000/api/check-amount-fees-limit"),
          headers: {
            "Authorization": 'Bearer $token',
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(depositForm.toJson()));
      var responseJson = json.decode(response.body);
      if (response.statusCode == 422) {
        if (responseJson['errors'] != null) {
          Common.showErrorDialog(responseJson['errors'], context);
        }
      } else if (response.statusCode == 500) {
        Common.showErrorMessageDialog(responseJson["error"], context);
      } else if (response.statusCode == 400) {
        depositForm.errorMsg = responseJson["error"];
      } else if (response.statusCode == 200) {
        depositForm.percentCharge = responseJson["data"]["percent_charge"];
        depositForm.fixedCharge = responseJson["data"]["fixed_charge"];
        depositForm.totalFees = responseJson["data"]["total_fees"];
        depositForm.totalAmount = responseJson["data"]["total_amount"];
      }
    } catch (e) {
      print(e);
    }
    return depositForm;
  }

  static Future<List<VodafoneCash>> getVodafoneCashWalletsList() async {
    List<VodafoneCash> vodafoneWalletsList = [];
    try {
      var token = await getToken();
      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/get-vodafone-cash-wallets"),
        headers: {
          "Authorization": 'Bearer $token',
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        if (responseJson["success"] == true) {
          List<dynamic> data = responseJson["data"];
          return data.map((json) => VodafoneCash.fromJson(json)).toList();
        }
      } else {
        //
      }
    } catch (e) {
      print(e);
    }
    return vodafoneWalletsList;
  }

  static Future<bool> confirmMoneyDeposit(
      DepositConfirmation model, BuildContext context) async {
    var token = await getToken();
    final uri = Uri.parse('http://127.0.0.1:8000/api/deposit-confirmation');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath('file', model.file!.path),
    );
    request.fields["currency_id"] = model.currencyId.toString();
    request.fields["payment_method_id"] = model.paymentMethodId.toString();
    request.fields["amount"] = model.amount.toString();
    // Add headers
    request.headers['Authorization'] = 'Bearer $token';
    final response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var responseJson = json.decode(responseBody);
    print(responseBody);
    if (response.statusCode == 200) {
      //display success message
      Common.showSuccessDialog(context, "your deposit is sent successfully");
      return true;
    } else if (response.statusCode == 422) {
      //display validation
      Common.showErrorDialog(responseJson["errors"], context);
    } else if (response.statusCode == 400 || response.statusCode == 500) {
      //display one error
      Common.showErrorMessageDialog(responseJson["error"], context);
    }
    return false;
  }
}
