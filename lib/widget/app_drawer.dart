import 'package:flutter/material.dart';
import 'package:shop/screen/order_screen.dart';
import 'package:shop/screen/product_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('hello'),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('shop'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductOverviewScreen.id),
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(OrdersScreen.id),
          )
        ],
      ),
    );
  }
}
