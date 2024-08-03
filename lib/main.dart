import 'package:flutter/material.dart';
import 'package:flutter_application_task/product_page.dart';
import 'package:flutter_application_task/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductList(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductPage(),
    );
  }
}

