import 'package:dash/zeus_app/pages/products_list_page.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 120,
            right: 60,
            left: 60,
            bottom: 60,
          ),
          child: Image.asset("lib/images/avocado.png"),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 25, left: 25, bottom: 20, top: 25),
          child: Text(
            "We deliver groceries at your doorstep",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "Fresh Items every day",
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey[800],
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple[800],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const ProductsListPage();
              }));
            },
            child: const Text(
              "Go To Store",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const Spacer()
      ],
    ));
  }
}
