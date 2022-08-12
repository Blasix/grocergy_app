import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery/models/products_model.dart';
import 'package:grocery/providers/product_provider.dart';
import 'package:grocery/widgets/feed_items.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/CategoryScreen";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
    final catText = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productsByCat = productProviders.findByCategory(catText);
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'All $catText',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: productsByCat.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/box.png',
                    scale: 2,
                  ),
                  Text(
                    'There are no ${catText.toLowerCase()} yet!\nStay tuned',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: utils.color,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          : Column(
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
                      itemCount: productsByCat.length,
                      crossAxisCount: 2,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 242,
                          child: ChangeNotifierProvider.value(
                            value: productsByCat[index],
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
