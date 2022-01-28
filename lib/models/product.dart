class Product {
  String id;
  String title;
  String description;
  String imageUrl;
  double price;
  bool isFavourite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
     this.isFavourite = false,
    required this.price,
  });
}
