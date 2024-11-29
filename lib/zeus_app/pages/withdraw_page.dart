import 'package:dash/models/payment_method.dart';
import 'package:dash/services/wallet_service.dart';
import 'package:dash/zeus_app/components/withdraw_form.dart';
import 'package:flutter/material.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  List<PaymentMethod>? paymentMethods;
  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
  }

  void _fetchPaymentMethods() async {
    paymentMethods = await WalletService.getPaymentMethods();
  }

  Widget displayPaymentMethods(BuildContext parentContext) {
    return FutureBuilder<List<PaymentMethod>?>(
      future: WalletService.getPaymentMethods(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PaymentMethod>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          ); // Loading indicator
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData && snapshot.data != null) {
          List<PaymentMethod> paymentMethods = snapshot.data!;
          // Display user information
          return Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1 / 1.2),
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottom(parentContext, paymentMethods[index].name,
                          paymentMethods[index].id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 1, // Border width
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(paymentMethods[index].image),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return const Text("User data not available");
        }
      },
    );
  }

  void showModalBottom(BuildContext parentContext, String name, int id) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true, // Makes the bottom sheet full height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.5, // Adjust the initial height as needed
            maxChildSize: 1.0, // Full screen when dragged
            minChildSize: 0.5, // Minimum height
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: WithdrawForm(
                    parentContext: parentContext,
                    methodName: name,
                    paymentMethodId: id,
                  ),
                ),
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw Money"),
      ),
      body: SafeArea(child: displayPaymentMethods(context)),
    );
  }
}
