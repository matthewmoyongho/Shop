import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widget/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String id = 'cart';

  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${carts.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium!
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      orders.addOrder(
                          carts.items.values.toList(), carts.totalAmount);
                      carts.clearCarts();
                    },
                    child: const Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: carts.itemLength,
              itemBuilder: (context, index) => CartWidget(
                productId: carts.items.keys.toList()[index],
                quantity: carts.items.values.toList()[index].quantity,
                price: carts.items.values.toList()[index].price,
                id: carts.items.values.toList()[index].id,
                title: carts.items.values.toList()[index].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
