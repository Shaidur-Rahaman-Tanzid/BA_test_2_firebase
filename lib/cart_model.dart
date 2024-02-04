import 'package:flutter/material.dart';

import 'model.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [];
  List<ItemModel> _cartItems = [];

  // get shopItems => _shopItems;

  List<ItemModel> get cartItems => _cartItems;

  bool isInCart(int index) {
    // Check if the product is already in the cart
    return _cartItems.contains(_shopItems[index]);
  }

  void addItemsToCart(ItemModel model) {
    // if (!isInCart(index)) {
    _cartItems.add(model);
    notifyListeners();
    // }
  }

  void removeItemsFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    // double totalPrice = 0;
    // for (int i = 0; i < _cartItems.length; i++) {
    //   totalPrice += double.parse(_cartItems[i][0]);
    // }
    // return totalPrice.toStringAsFixed(2);
    return "";
  }
}
