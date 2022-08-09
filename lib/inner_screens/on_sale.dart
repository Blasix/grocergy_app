import 'package:flutter/material.dart';
import 'package:grocery/widgets/on_sale_widget.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../providers/product_provider.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> onSaleProducts = productProviders.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: onSaleProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/box.png',
                    scale: 2,
                  ),
                  Text(
                    'No Products On Sale yet!\nStay tuned',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: utils.color,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: 100 / 90.2,
              children: List.generate(onSaleProducts.length, (index) {
                return ChangeNotifierProvider.value(
                  value: onSaleProducts[index],
                  child: const OnSaleWidget(),
                );
              }),
            ),
    );
  }
}
