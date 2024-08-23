import 'package:flutter/material.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addProduct(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _cart.fold(0.0, (sum, item) => sum + item.price);
  }
}
