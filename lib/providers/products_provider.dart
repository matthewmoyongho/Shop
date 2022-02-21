import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl: 'https://www.w3schools.com/css/img_lights.jpg',
      //'assets/images/onboard3.png',
    ),
  ];

  //bool _showFavouriteOnly = false;

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favouriteProducts {
    return _products.where((element) => element.isFavourite).toList();
  }

  Product findById(String id) {
    return products.firstWhere((element) => element.id == id);
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

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      imageUrl: product.imageUrl,
      price: product.price,
      id: DateTime.now().toString(),
    );
    _products.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _products.indexWhere((prod) => prod.id == id);
    _products[prodIndex] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    final prodIndex = _products.indexWhere((prod) => prod.id == id);
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
