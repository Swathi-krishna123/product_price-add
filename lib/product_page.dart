import 'package:flutter/material.dart';
import 'package:flutter_application_task/product_model.dart';
import 'package:flutter_application_task/product_row.dart';
import 'package:flutter_application_task/provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Consumer<ProductList>(
                builder: (context, productList, child) {
                  return ListView.builder(
                    itemCount: productList.products.length,
                    itemBuilder: (context, index) {
                      final product = productList.products[index];
                      return ProductRow(
                        index: index,
                        nameController: TextEditingController(text: product.name),
                        priceController: TextEditingController(text: product.price.toString()),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Consumer<ProductList>(
                  builder: (context, productList, child) {
                    return Text(
                      '₹${productList.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final productList = Provider.of<ProductList>(context, listen: false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order Submitted! Total Price: ₹${productList.totalPrice.toStringAsFixed(2)}'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Submit Order'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ProductList>(context, listen: false).addProduct(
            Product(name: '', price: 0.0),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Product',
      ),
    );
  }
}
