import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widget/app_drawer.dart';
import '../widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = 'OrdersScreen';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orders.orderedCarts.length,
          itemBuilder: (context, index) {
            return OrderItem(orders.orderedCarts[index]);
          }),
    );
  }
}
