import 'package:flutter/material.dart';
import 'package:flutter_application_task/product_model.dart';

class ProductList extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  double get totalPrice {
    return _products.fold(0.0, (sum, product) => sum + product.price);
  }
}