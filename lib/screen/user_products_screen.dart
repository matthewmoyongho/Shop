import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screen/edit_product_screen.dart';
import '../widget/app_drawer.dart';
import '../widget/user_product.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const String id = 'UserProductScreen';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.id);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: products.products.length,
            itemBuilder: (_, index) => Column(
                  children: [
                    UserProduct(
                      title: products.products[index].title,
                      imageUrl: products.products[index].imageUrl,
                    ),
                    Divider(),
                  ],
                )),
      ),
    );
  }
}
