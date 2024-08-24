import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
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
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorTheme.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorTheme.backgroundclr,
        title: Text(
          "ORDER INFO",
          style: GlTextStyles.robotoStyl(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.0),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.4,
                ),
                Text(
                  'Your order has been placed successfully!',
                  style: TextStyle(
                    color: ColorTheme.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Payment Method: ${getPaymentMethod()}',
                  style: TextStyle(
                    color: ColorTheme.black,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    color: ColorTheme.backgroundclr,
                    onPressed: () async {
                      final pdf = pdfWidgets.Document();
                      pdf.addPage(
                        pdfWidgets.Page(
                          build: (pdfContext) => pdfWidgets.Column(
                            children: [
                              pdfWidgets.Text('Product Name(s)'),
                              ...products.map(
                                (product) => pdfWidgets.Text(
                                  '${product.name} x${product.quantity}',
                                ),
                              ),
                              pdfWidgets.Text(
                                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                              ),
                              pdfWidgets.Text(
                                'Thank you for shopping with us!',
                              ),
                            ],
                          ),
                        ),
                      );
                      await Printing.layoutPdf(
                        onLayout: (PdfPageFormat format) async => pdf.save(),
                      );
                    },
                    child: Text(
                      'PRINT PDF',
                      style: TextStyle(color: ColorTheme.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getPaymentMethod() {
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
