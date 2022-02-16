import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';

import '../providers/products_provider.dart';

import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  bool showFavourite;
  ProductsGrid(this.showFavourite);
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = showFavourite?productsProvider.favouriteProducts: productsProvider.products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => ChangeNotifierProvider<Product>.value(
        value: products[index],
        child: ProductItem(
          // id: products[index].id,
          // imageUrl: products[index].imageUrl,
          // title: products[index].title,
        ),
      ),
    );
  }
}
