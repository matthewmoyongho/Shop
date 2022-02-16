import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products =  [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/images/onboard1.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'assets/images/onboard3.png',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl: 'assets/images/onboard2.png',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'assets/images/onboard3.png',
    ),
  ];


  //bool _showFavouriteOnly = false;

  List<Product> get products {

    return [..._products];
  }

  List<Product> get favouriteProducts {

      return _products.where((element) => element.isFavourite).toList();

  }

  Product findById(String id){
    return products.firstWhere((element) => element.id==id);
  }

  // void showFavourite(){
  //   _showFavouriteOnly=true;
  //   notifyListeners();
  // }
  //
  // void showAll(){
  //   _showFavouriteOnly=false;
  //   notifyListeners();
  // }

  void addProduct(value) {
  //  _products.add(value);
    notifyListeners();
  }
}
