import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/cart_screen/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ecommerce_task/presentation/cart_screen/view/cart_screen.dart';
import 'package:ecommerce_task/presentation/details_screen/view/details_screen.dart';
import 'package:ecommerce_task/presentation/home_screen/data/product_data.dart';
import 'package:ecommerce_task/presentation/home_screen/model/product_model.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = dummyProducts;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorTheme.backgroundclr,
        title: Text(
          'BAG NEST',
          style: GlTextStyles.robotoStyl(),
        ),
        actions: [
          badges.Badge(
            badgeContent: Text(
              cartProvider.cart.length.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color:
                    cartProvider.cart.isNotEmpty ? Colors.red : ColorTheme.text,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0), // Add padding around the grid view
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: .5,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding:
                const EdgeInsets.all(8.0), // Add padding around each grid item
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(product: product),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8.0)),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '₹${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Center(
                            child: MaterialButton(
                              color: ColorTheme.buttoncolor,
                              shape: StadiumBorder(),
                              onPressed: () {
                                cartProvider.addProduct(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('${product.name} added to cart'),
                                  ),
                                );
                              },
                              child: Text(
                                'Add to Cart',
                                style: GlTextStyles.hintstyle(
                                  size: 15,
                                  color: ColorTheme.highlights,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
