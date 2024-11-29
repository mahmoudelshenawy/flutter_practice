import 'package:dash/data/data_local_storage.dart';
import 'package:dash/models/cartItem.dart';
import 'package:dash/models/product.dart';
import 'package:dash/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartModel extends ChangeNotifier {
  final List<Product> _listProducts = [
    Product(
      id: 1,
      productName: "Avocado",
      imagePath: "lib/images/avocado.png",
      price: "4.00",
      color: Colors.green,
    ),
    Product(
      id: 2,
      productName: "Apple",
      imagePath: "lib/images/apple.png",
      price: "5.00",
      color: Colors.red,
    ),
    Product(
      id: 3,
      productName: "Banana",
      imagePath: "lib/images/banana.png",
      price: "6.00",
      color: Colors.yellow,
    ),
    Product(
      id: 4,
      productName: "Cucmber",
      imagePath: "lib/images/cucumber.png",
      price: "7.00",
      color: Colors.green,
    ),
    Product(
      id: 5,
      productName: "Eggplant",
      imagePath: "lib/images/eggplant.png",
      price: "8.00",
      color: Colors.purple,
    ),
    Product(
      id: 6,
      productName: "Tomato",
      imagePath: "lib/images/tomato.png",
      price: "9.00",
      color: Colors.red,
    ),
  ];

  int _clickCount = 0;
  List<User> _usersList = [];
  List<Product> _cartItems = [];
  List<CartItem> _cartList = [];

  List<Product> get listProducts => _listProducts;
  int get clickCount => _clickCount;
  List<User> get usersList => _usersList;
  List<Product> get cartItems => _cartItems;
  List<CartItem> get cartList => _cartList;
  //act on data list

  void incrementClicks() {
    _clickCount++;
    notifyListeners();
  }

  void publishCounter() {
    _clickCount = 5;
    notifyListeners();
  }

  Future<void> getUsersList() async {
    var token = await getToken();
    var response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/users"),
      headers: {"Authorization": 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      if (responseJson["success"] == true) {
        List<dynamic> data = responseJson["data"];
        List<User> users = data.map((json) => User.fromJson(json)).toList();

        _usersList.addAll(users);
        notifyListeners();
      }
    }
  }

  void addToCart(int id) {
    var product = _listProducts.where((pro) => pro.id == id).first;
    _clickCount++;
    print(product);
    var cartItem = _cartList.where((item) => item.productId == id).firstOrNull;
    if (cartItem != null) {
      cartItem.quantity += 1;
      var index = _cartList.indexOf(cartItem);
      _cartList[index] = cartItem;
    } else {
      var cartId = _cartList.isNotEmpty ? _cartList.last.id + 1 : 1;
      print(cartId);
      var cartItem = CartItem(
          id: cartId,
          productId: id,
          price: product.price,
          quantity: 1,
          product: product);
      _cartList.add(cartItem);
    }
    print(cartItem);
    //check if the item already exists
    _cartItems.add(product);
    notifyListeners();
  }

  void removeItemFromCart(int id) {
    var cartItem = _cartList.where((item) => item.id == id).firstOrNull;
    if (cartItem != null) {
      var index = _cartList.indexOf(cartItem);
      if (cartItem.quantity == 1) {
        _cartList.removeAt(index);
        notifyListeners();
        return;
      }
      cartItem.quantity -= 1;
      _cartList[index] = cartItem;
    }
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartItems.removeWhere((pro) => pro.id == id);
    notifyListeners();
  }

  String calculateTotalPrice() {
    double totalAmount = 0;
    for (var i = 0; i < _cartList.length; i++) {
      totalAmount += _cartList[i].total();
    }
    return totalAmount.toString();
  }
}
