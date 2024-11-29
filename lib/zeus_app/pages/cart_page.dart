import 'package:dash/data/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
        ),
        backgroundColor: Colors.blue[400],
        foregroundColor: Colors.white,
        elevation: 7,
      ),
      body: Consumer<CartModel>(builder: (context, value, child) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: value.cartList.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: Image.asset(
                            value.cartList[index].product.imagePath,
                            height: 36,
                          ),
                          title:
                              Text(value.cartList[index].product.productName),
                          subtitle:
                              Text(value.cartList[index].total().toString()),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     Provider.of<CartModel>(context, listen: false)
                          //         .removeFromCart(
                          //             value.cartList[index].productId);
                          //   },
                          //   icon: const Icon(Icons.cancel),
                          // ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .addToCart(
                                          value.cartList[index].productId);
                                },
                                icon: const Icon(
                                    Icons.add_circle_outline_outlined),
                              ),
                              Text(
                                value.cartList[index].quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Provider.of<CartModel>(context,
                                            listen: false)
                                        .removeItemFromCart(
                                            value.cartList[index].id);
                                  },
                                  icon:
                                      const Icon(Icons.remove_circle_outline)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(36),
              child: Container(
                // color: Colors.green[400],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[400],
                ),
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Cost :",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "\$ ${value.calculateTotalPrice()}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Row(
                        children: [
                          Text(
                            "Pay Now",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
