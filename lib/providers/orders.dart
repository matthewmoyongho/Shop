import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.dateTime,
      required this.id,
      required this.amount,
      required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orderedCarts = [];
  List<OrderItem> get orderedCarts {
    return [..._orderedCarts];
  }

  void addOrder(List<CartItem> cartLists, double total) {
    _orderedCarts.insert(
      0,
      OrderItem(
          dateTime: DateTime.now(),
          id: DateTime.now().toString(),
          amount: total,
          products: cartLists),
    );
    notifyListeners();
  }
}
