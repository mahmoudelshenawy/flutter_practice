import 'package:dash/data/cart_model.dart';
import 'package:dash/models/user.dart';
import 'package:dash/services/auth_service.dart';
import 'package:dash/zeus_app/components/product_item_tile.dart';
import 'package:dash/zeus_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartModel>(context, listen: false).publishCounter();
    Future.microtask(
        () => Provider.of<CartModel>(context, listen: false).getUsersList());
  }

  Widget DisplayUserName() {
    return FutureBuilder<User?>(
        future: AuthService.getUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData && snapshot.data != null) {
            User user = snapshot.data!;
            return Text(
              'hello, ${user.name}',
              style: const TextStyle(fontSize: 16),
            );
          } else {
            return const Text("");
          }
        });
  }

  void addToCart() {
    //
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const CartPage();
        })),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: const Icon(
          Icons.shopping_bag,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DisplayUserName(),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Lets get some items",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Fresh Items",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Consumer<CartModel>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(value.clickCount.toString()),
              );
            }),
            Consumer<CartModel>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child:
                    Text("total users: " + value.usersList.length.toString()),
              );
            }),
            Expanded(
              child: Consumer<CartModel>(
                builder: (context, value, child) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.2),
                    itemCount: value.listProducts.length,
                    itemBuilder: (context, index) {
                      return ProductItemTile(
                        id: value.listProducts[index].id,
                        productName: value.listProducts[index].productName,
                        imagePath: value.listProducts[index].imagePath,
                        price: value.listProducts[index].price,
                        color: value.listProducts[index].color,
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .addToCart(value.listProducts[index].id);
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
