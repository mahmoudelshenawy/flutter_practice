import 'package:dash/models/withdraw_confirmation.dart';
import 'package:dash/services/wallet_service.dart';
import 'package:flutter/material.dart';

class WithdrawConfirmationPage extends StatefulWidget {
  final WithdrawConfirmation withdrawConfirmation;
  const WithdrawConfirmationPage(
      {super.key, required this.withdrawConfirmation});

  @override
  State<WithdrawConfirmationPage> createState() =>
      _WithdrawConfirmationPageState();
}

class _WithdrawConfirmationPageState extends State<WithdrawConfirmationPage> {
  bool isSending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdrawal Confirmation"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Withdrawn Amount:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(widget.withdrawConfirmation.amount)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Fees:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(widget.withdrawConfirmation.totalFees)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "You Will Get:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(widget.withdrawConfirmation.totalAmount)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextButton(
                  onPressed: () async {
                    if (!isSending) {
                      await WalletService.confirmWithdraw(context);
                      setState(() {
                        isSending = true;
                      });
                    }
                  },
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
