import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/inner_screens/product_details.dart';
import 'package:grocery/models/viewed_model.dart';
import 'package:grocery/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../services/utils.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({Key? key}) : super(key: key);

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final Color color = utils.color;
    final viewedModel = Provider.of<ViewedModel>(context);

    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct =
        productProvider.findProdById(viewedModel.productID);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart =
        cartProvider.getCartItems.containsKey(viewedModel.productID);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    return ListTile(
      subtitle: Text('€${usedPrice.toStringAsFixed(2)}'),
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: viewedModel.productID);
      },
      leading: FancyShimmerImage(
        imageUrl: getCurrentProduct.imageUrl,
        height: 58,
        width: 58,
        boxFit: BoxFit.contain,
      ),
      title:
          TextWidget(text: getCurrentProduct.title, color: color, textSize: 18),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: utils.greenColor,
          ),
          child: IconButton(
            icon: isInCart ? const Icon(Icons.check) : const Icon(Icons.add),
            onPressed: () {
              isInCart
                  ? null
                  : cartProvider.addProductsToCart(
                      productID: getCurrentProduct.id,
                      quantity: 1,
                    );
            },
            color: utils.color,
          ),
        ),
      ),
    );
  }
}
