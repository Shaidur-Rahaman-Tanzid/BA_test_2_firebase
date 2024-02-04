import 'package:flutter/material.dart';

import 'model.dart';

class CartModel extends ChangeNotifier {
  //final List _shopItems = [];
   List<ItemModel> _cartItems = [];

  List<ItemModel> get cartItems => _cartItems;

  bool isInCart(ItemModel model) {
    // Check if the product is already in the cart
    return _cartItems.contains(model);
  }

  void addItemsToCart(ItemModel model) {
    // Check if the product is already in the cart
    if (isInCart(model)) {
      // If item is already in the cart, find it and increase the quantity
      int index = _cartItems.indexOf(model);
      _cartItems[index].quantity = _cartItems[index].quantity! + 1;
    } else {
      // If item is not in the cart, add it with quantity 1
      model.quantity = 1;
      _cartItems.add(model);
    }

    notifyListeners();
  }

  void removeItemsFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }
  void incrementItem(int index) {
    _cartItems[index].quantity = _cartItems[index].quantity! + 1;
    notifyListeners();
  }
  void decrementItem(int index) {
    if (_cartItems[index].quantity! > 1) {
      _cartItems[index].quantity = _cartItems[index].quantity! - 1;
      notifyListeners();
    } else {
      // If quantity is already 1, remove the item from the cart
      removeItemsFromCart(index);
    }
  }
  double calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice += double.parse(_cartItems[i].price!) * _cartItems[i].quantity!;
    }
    return totalPrice;
  }
}
