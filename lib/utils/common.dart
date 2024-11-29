import 'package:flutter/material.dart';

class Common {
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

  static void showSuccessDialog(BuildContext context, String? message) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message ?? 'Your withdrawal was successful!'),
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
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => const WithdrawPage()),
    //   );
    // });
  }
}
