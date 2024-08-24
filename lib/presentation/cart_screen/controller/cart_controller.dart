import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_task/presentation/cart_screen/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cart = [];
  double _totalPrice = 0.0;

  List<Product> get cart => _cart;
  double get totalPrice => _totalPrice;

  void addProduct(Product product) {
    _cart.add(product);
    _totalPrice += product.price;
    notifyListeners();
  }

  void removeProduct(Product product) {
    _cart.remove(product);
    _totalPrice -= product.price;
    notifyListeners();
  }
}
