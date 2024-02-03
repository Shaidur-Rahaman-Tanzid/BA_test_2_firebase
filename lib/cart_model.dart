import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier{

  final List _shopItems =
  [
    [ "249.50",  "SONY Premium Headphones",  "Model: WH-1000XM4, Black",  "assets/images/Rectangle 28.png"],
    [ "129.00",  "SONY Wireless Headphones",  "Model: WH-1000XM4, Beige",  "assets/images/Rectangle 30.png"],
    [ "349.99",  "Lenovo Laptop",  "Model: LH-200MX5, Grey",  "assets/images/image 12.png"],
    [ "1250.99",  "SONY TV",  "Model: WH-1000XM4, Beige",  "assets/images/image 9.png"]
  ];
  List _cartItems = [];

  get shopItems => _shopItems;

  get cartItems => _cartItems;

  void addItemsToCart(int index){
      _cartItems.add(_shopItems[index]);
      notifyListeners();
  }

  void removeItemsFromCart(int index){
    _cartItems.removeAt(index);
    notifyListeners();
  }
  String calculateTotal(){
    double totalPrice =0;
    for(int i=0; i< _cartItems.length;i++){
      totalPrice = double.parse(_cartItems[i][1]);
    };
    return totalPrice.toStringAsFixed(2);
  }
}