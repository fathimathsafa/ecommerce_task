import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_task/presentation/order_success_screen/view/order_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final List<Product> products;

  PaymentScreen({required this.products});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 1; // Default to Google Pay

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Payment Method'),
            SizedBox(height: 20),
            ListTile(
              title: Text('Google Pay'),
              leading: Radio(
                value: 1,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value as int;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Paytm'),
              leading: Radio(
                value: 2,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value as int;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Cash on Delivery'),
              leading: Radio(
                value: 3,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value as int;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSuccessScreen(
                      products: widget.products,
                      paymentMethod: _selectedPaymentMethod,
                    ),
                  ),
                );
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
