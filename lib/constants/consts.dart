import 'package:grocery/models/products_model.dart';

class Consts {
  static final List<String> authImages = [
    'assets/images/landing/buy-on-laptop.jpg',
    'assets/images/landing/buy-through.png',
    'assets/images/landing/buyfood.jpg',
    'assets/images/landing/grocery-cart.jpg',
    'assets/images/landing/grocery-cart.jpg',
    'assets/images/landing/store.jpg',
    'assets/images/landing/vergtablebg.jpg',
  ];

  static List<ProductModel> products = [
    ProductModel(
      id: '1',
      title: 'Apricots',
      imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
      productCategoryName: 'Fruits',
      price: 3.99,
      salePrice: 2.99,
      isOnSale: false,
      isPiece: false,
    ),
  ];
}
