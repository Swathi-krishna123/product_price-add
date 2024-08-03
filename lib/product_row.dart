
import 'package:flutter/material.dart';
import 'package:flutter_application_task/product_model.dart';
import 'package:flutter_application_task/provider.dart';
import 'package:provider/provider.dart';

class ProductRow extends StatelessWidget {
  final int index;
  final TextEditingController nameController;
  final TextEditingController priceController;

  ProductRow({
    required this.index,
    required this.nameController,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context, listen: false);

    return Padding(
      key: ValueKey(index),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Name',
              ),
              onChanged: (value) {
                productList.products[index] = Product(
                  name: value,
                  price: double.tryParse(priceController.text) ?? 0.0,
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
            ),
          ),
          SizedBox(width: 16), // Add space between the text fields
          Expanded(
            child: TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final price = double.tryParse(value) ?? 0.0;
                productList.products[index] = Product(
                  name: nameController.text,
                  price: price,
                );
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter price';
                }
                final number = double.tryParse(value);
                if (number == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              productList.removeProduct(index);
            },
          ),
        ],
      ),
    );
  }
}
