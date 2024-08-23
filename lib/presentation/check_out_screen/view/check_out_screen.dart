import 'package:ecommerce_task/presentation/payment_screen/view/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product> products;

  CheckoutScreen({required this.products});

  double _calculateTotalPrice(List<Product> products) {
    return products.fold(0.0, (sum, product) => sum + (product.price * product.quantity));
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice(products);

    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Checkout Details'),
            SizedBox(height: 20),
            ...products.map(
              (product) => ListTile(
                leading: Image.network(product.imageUrl),
                title: Text(product.name),
                subtitle: Text('\$${product.price}'),
                trailing: Text('x${product.quantity}'),
              ),
            ),
            SizedBox(height: 20),
            Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(products: products),
                  ),
                );
              },
              child: Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
