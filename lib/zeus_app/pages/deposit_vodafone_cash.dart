import 'dart:io';

import 'package:dash/models/deposit_confirmation.dart';
import 'package:dash/models/deposit_form.dart';
import 'package:dash/models/vodafone_cash.dart';
import 'package:dash/services/deposit_service.dart';
import 'package:dash/zeus_app/pages/deposit_page.dart';
import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
// import 'package:image_picker/image_picker.dart';

class DepositVodafoneCash extends StatefulWidget {
  final DepositForm depositForm;
  const DepositVodafoneCash({super.key, required this.depositForm});

  @override
  State<DepositVodafoneCash> createState() => _DepositVodafoneCashState();
}

class _DepositVodafoneCashState extends State<DepositVodafoneCash> {
  List<VodafoneCash> vodafoneCashWallets = [];
  VodafoneCash? selectedvodafoneCashWallet;
  final _formKey = GlobalKey<FormState>();
  File? _selectedFile;
  String? fileName;
  @override
  void initState() {
    _getVodafoneCashWallets();
    super.initState();
  }

  Future<void> _getVodafoneCashWallets() async {
    var walletsList = await DepositService.getVodafoneCashWalletsList();
    setState(() {
      vodafoneCashWallets = walletsList;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePickers();
    final pickedFile = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      selectCount: 1,
    );

    if (pickedFile != null) {
      print("hello did you got it? ${pickedFile.first.path}");
      String path = pickedFile.first.path ?? "";
      var pathArr = path.split("/");
      var filename = pathArr[pathArr.length - 1];
      setState(() {
        _selectedFile = File(pickedFile.first.path ?? "");
        fileName = filename;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deposit Confirmation"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
        child: Column(
          children: [
            Text(
              "Deposit Via ${widget.depositForm.methodName}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            vodafoneCashWallets.isEmpty
                ? const CircularProgressIndicator()
                : DropdownButtonFormField<VodafoneCash>(
                    value: selectedvodafoneCashWallet,
                    items: vodafoneCashWallets.map((paymentMethod) {
                      return DropdownMenuItem<VodafoneCash>(
                        value: paymentMethod,
                        child: Text(paymentMethod.number),
                      );
                    }).toList(),
                    onChanged: (newValue) async {
                      setState(() {
                        selectedvodafoneCashWallet = newValue!;
                      });
                      //get details if needed
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select Wallet',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null ? 'Please select a wallet number' : null,
                  ),
            const SizedBox(
              height: 18,
            ),
            Visibility(
              visible: fileName != null,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(fileName ?? ""),
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
              child: TextButton(
                  onPressed: _pickImage,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Upload Image",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Fees: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.depositForm.totalFees!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Amount Before: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.depositForm.amount.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Amount After: ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.depositForm.totalAmount!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            //SubmitButton
            ElevatedButton(
                onPressed: _selectedFile == null
                    ? null
                    : () async {
                        DepositConfirmation model = DepositConfirmation(
                          amount: widget.depositForm.amount,
                          currencyId: widget.depositForm.currencyId,
                          paymentMethodId: widget.depositForm.paymentMethodId,
                          file: _selectedFile,
                        );

                        var response = await DepositService.confirmMoneyDeposit(
                            model, context);
                        if (response) {
                          // Navigate after 2 seconds
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const DepositPage()),
                            );
                          });
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[500],
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
