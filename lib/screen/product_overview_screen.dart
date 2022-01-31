import 'package:flutter/material.dart';

import '../widget/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  static const id = 'productOverviewScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyShop')),
      body: ProductsGrid(),
    );
  }
}

