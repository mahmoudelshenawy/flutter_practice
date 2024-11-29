import 'package:dash/data/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItemTile extends StatelessWidget {
  final int id;
  final String productName;
  final String imagePath;
  final String price;
  final color;
  void Function()? onPressed;

  ProductItemTile(
      {super.key,
      required this.id,
      required this.productName,
      required this.imagePath,
      required this.price,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: color[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 65,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(productName),
            Consumer<CartModel>(builder: (context, value, child) {
              return MaterialButton(
                onPressed: onPressed,
                color: color[800],
                child: Text(
                  '\$' + price,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
