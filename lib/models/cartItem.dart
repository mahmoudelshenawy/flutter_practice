import 'package:dash/models/product.dart';

class CartItem {
  final int id;
  final int productId;
  int quantity;
  final String price;
  final Product product;
  // double total() => 22;
  double total() => quantity * double.parse(price);

  CartItem({
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.product,
  });
}
