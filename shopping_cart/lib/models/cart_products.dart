import 'package:flutter/material.dart';
import 'package:shopping_cart/models/products.dart';

class CartItemList with ChangeNotifier {
  List<CartItem> _cartitems = [];
  get getlength => _cartitems.length;
  String name(index) => _cartitems[index].item.name;
  String imageLocation(index) => _cartitems[index].item.imageLocation;
  int price(index) => _cartitems[index].item.price;
  int quantity(index) => _cartitems[index].quantity;

  void addtoCart(CartItem item) {
    int index = _cartitems
        .indexWhere(((element) => element.item.name == item.item.name));
    if (index == -1) {
      _cartitems.add(item);
    } else {
      _cartitems[index].quantity += item.quantity;
    }
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartitems.removeAt(index);
    getTotal();
    notifyListeners();
  }

  void updateCart(int index, int quantity) {
    _cartitems[index].quantity = quantity;
    getTotal();
    notifyListeners();
  }

  void clearCart() {
    _cartitems.clear();
    notifyListeners();
  }

  int getTotal() {
    if (_cartitems.isEmpty) {
      return 0;
    } else {
      int sum = 0;
      _cartitems.forEach((element) {
        sum += element.quantity * element.item.price;
      });
      return sum;
    }
  }
}
