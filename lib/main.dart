import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screen/cart_screen.dart';
import './screen/order_screen.dart';
import './screen/product_detail_screen.dart';
import './screen/product_overview_screen.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/products_provider.dart';
import '../screen/edit_product_screen.dart';
import '../screen/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(value: Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.purple,
            ),
          ),
        ),
        initialRoute: ProductOverviewScreen.id,
        routes: {
          ProductOverviewScreen.id: (context) => ProductOverviewScreen(),
          ProductDetailScreen.id: (context) => ProductDetailScreen(),
          CartScreen.id: (context) => CartScreen(),
          OrdersScreen.id: (context) => OrdersScreen(),
          UserProductsScreen.id: (context) => UserProductsScreen(),
          EditProductScreen.id: (context) => EditProductScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: const Text(
          'Let\'s Begin to build',
        ),
      ),
    );
  }
}
