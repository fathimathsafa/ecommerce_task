import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptGenerator {
  static pw.Document generate({
    required List<Product> products,
    required double totalPrice,
    required String transactionId,
    required DateTime date,
  }) {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Receipt', style: pw.TextStyle(fontSize: 24.0, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16.0),
            pw.Text('Transaction ID: $transactionId'),
            pw.Text('Date: ${date.toLocal().toString().split(' ')[0]}'),
            pw.SizedBox(height: 16.0),
            pw.Table.fromTextArray(
              headers: ['Product', 'Quantity', 'Price'],
              data: products
                  .map(
                    (product) => [
                      product.name,
                      product.quantity.toString(),
                      '\$${(product.price * product.quantity).toStringAsFixed(2)}'
                    ],
                  )
                  .toList(),
            ),
            pw.SizedBox(height: 16.0),
            pw.Text('Total: \$${totalPrice.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18.0, fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ),
    );
    return pdf;
  }
}
