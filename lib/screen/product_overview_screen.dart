import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/screen/cart_screen.dart';
import 'package:shop/widget/app_drawer.dart';
import 'package:shop/widget/badge.dart';

import '../widget/products_grid.dart';

enum FilterOptions {
  isFavourite,
  isAll,
}

class ProductOverviewScreen extends StatefulWidget {
  static const id = '/';

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavourite = false;
  bool isLoading = true;

  Future<void> fetchData() async {
    Provider.of<ProductsProvider>(context, listen: false).fetchProducts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final carts = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions val) {
              if (val == FilterOptions.isFavourite) {
                setState(() {
                  _showFavourite = true;
                });
              } else {
                setState(() {
                  _showFavourite = false;
                });
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('only favourite'),
                value: FilterOptions.isFavourite,
              ),
              const PopupMenuItem(
                child: Text('show all'),
                value: FilterOptions.isAll,
              )
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (context, carts, ch) =>
                Badge(child: ch!, value: carts.items.length.toString()),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.id);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavourite),
    );
  }
}
