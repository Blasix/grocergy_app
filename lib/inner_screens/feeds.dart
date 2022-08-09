import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery/constants/consts.dart';
import 'package:grocery/models/products_model.dart';
import 'package:grocery/providers/product_provider.dart';
import 'package:grocery/widgets/feed_items.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreen";
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'All Products',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                maxLines: 1,
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: utils.blueColor,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: utils.color,
                      width: 1,
                    ),
                  ),
                  label: const Icon(Icons.search),
                  hintText: 'Search Product',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchTextController.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(Icons.close,
                        color: _searchTextFocusNode.hasFocus
                            ? utils.redColor
                            : utils.color),
                  ),
                ),
                cursorColor: utils.blueColor,
              ),
            ),
          ),
          Expanded(
            child: MasonryGridView.count(
                itemCount: allProducts.length,
                crossAxisCount: 2,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 242,
                    child: ChangeNotifierProvider.value(
                      value: allProducts[index],
                      child: const FeedsWidget(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
