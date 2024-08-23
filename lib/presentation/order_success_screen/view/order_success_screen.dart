import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:ecommerce_task/presentation/cart_screen/model/cart_model.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';

class OrderSuccessScreen extends StatelessWidget {
  final List<Product> products;
  final int paymentMethod;

  OrderSuccessScreen({required this.products, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    final totalPrice = Cart.getTotalPrice();

    return Scaffold(
      appBar: AppBar(title: Text('Order Success')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your order has been placed successfully!'),
            SizedBox(height: 20),
            Text('Payment Method: ${_getPaymentMethod()}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Generate and print the invoice PDF
                final pdf = pdfWidgets.Document();
                pdf.addPage(
                  pdfWidgets.Page(
                    build: (pdfContext) => pdfWidgets.Column(
                      children: [
                        pdfWidgets.Text('Product Name(s)'),
                        ...products.map(
                          (product) => pdfWidgets.Text(
                              '${product.name} x${product.quantity}'),
                        ),
                        pdfWidgets.Text(
                            'Total Price: \$${totalPrice.toStringAsFixed(2)}'),
                        pdfWidgets.Text('Thank you for shopping with us!'),
                      ],
                    ),
                  ),
                );
                await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async => pdf.save(),
                );
              },
              child: Text('Print Invoice'),
            ),
          ],
        ),
      ),
    );
  }

  String _getPaymentMethod() {
    switch (paymentMethod) {
      case 1:
        return 'Google Pay';
      case 2:
        return 'Paytm';
      case 3:
        return 'Cash on Delivery';
      default:
        return 'Unknown';
    }
  }
}
