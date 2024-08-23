import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';

class Cart {
  static List<Product> _products = [];

  static void addProduct(Product product) {
    _products.add(product);
  }

  static void removeProduct(Product product) {
    _products.remove(product);
  }

  static List<Product> getProducts() {
    return _products;
  }

  static double getTotalPrice() {
    double total = 0.0;
    for (var product in _products) {
      total += product.price * product.quantity;
    }
    return total;
  }
}
