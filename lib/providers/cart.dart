import 'package:flutter/foundation.dart';

class CartItem {
  String id;
  String title;
  int quantity;
  double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemLength {
    return _items.length;
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            quantity: value.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  double get totalAmount {
    double amount = 0.0;
    _items.forEach((key, cart) {
      amount += cart.price * cart.quantity;
    });
    return amount;
  }

  void removeCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity > 1) {
      _items.update(
          id,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity - 1));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clearCarts() {
    _items = {};
    notifyListeners();
  }
}
