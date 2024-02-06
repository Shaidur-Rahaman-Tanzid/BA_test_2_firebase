import 'package:flutter/material.dart';

import 'model.dart';

class CartModel extends ChangeNotifier {
  //final List _shopItems = [];
  List<ItemModel> _cartItems = [];

  List<ItemModel> get cartItems => _cartItems;

  bool isInCart(ItemModel model) {
    var x = _cartItems.contains(model);
    return x;
  }

  void addItemsToCart(ItemModel model) {
    if (isInCart(model)) {
      int index = _cartItems.indexOf(model);
      _cartItems[index].quantity = _cartItems[index].quantity! + 1;
    } else {
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
      removeItemsFromCart(index);
    }
  }

  double calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalPrice +=
          double.parse(_cartItems[i].price!) * _cartItems[i].quantity!;
    }
    return totalPrice;
  }
}
