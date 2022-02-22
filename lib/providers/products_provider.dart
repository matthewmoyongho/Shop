import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl: 'https://www.w3schools.com/css/img_lights.jpg',
    //   //'assets/images/onboard3.png',
    // ),
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
  Future<void> fetchProducts() async {
    final url = Uri.parse(
        'https://shop-app-7b78b-default-rtdb.firebaseio.com/products.json');
    try {
      http.Response response = await http.get(url);
      final List<Product> loadedProd = [];
      final productsData = jsonDecode(response.body) as Map<String, dynamic>;
      productsData.forEach((prodId, prodData) {
        loadedProd.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            isFavourite: prodData['isFavorite']));
      });
      _products = loadedProd;
      notifyListeners();
      //print(loadedProd[0].isFavourite);
      // _products.add(productsData.)
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://shop-app-7b78b-default-rtdb.firebaseio.com/products.json');
    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode(
          {
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavourite,
          },
        ),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: jsonDecode(response.body)['name'],
      );
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _products.indexWhere((prod) => prod.id == id);
    final url = Uri.parse(
        'https://shop-app-7b78b-default-rtdb.firebaseio.com/products/$id.json');
    try {
      await http.patch(
        url,
        body: jsonEncode(
          {
            'title': newProduct.title,
            'price': newProduct.price,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
          },
        ),
      );
    } catch (error) {
      rethrow;
    }

    _products[prodIndex] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    // final prodIndex = _products.indexWhere((prod) => prod.id == id);
    final url = Uri.parse(
        'https://shop-app-7b78b-default-rtdb.firebaseio.com/products/$id.json');
    http.delete(url);
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
