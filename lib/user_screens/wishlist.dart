import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/inner_screens/empty.dart';
import 'package:provider/provider.dart';
import '../providers/dark_theme_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemList = wishlistProvider.getWishlistItems.values.toList();
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Wishlist (${wishlistItemList.length})',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
        actions: [
          Visibility(
            visible: wishlistItemList.isNotEmpty,
            child: IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      final themeState =
                          Provider.of<DarkThemeProvider>(context);
                      final utils = Utils(context);
                      return AlertDialog(
                        backgroundColor: themeState.getDarkTheme
                            ? Theme.of(context).cardColor
                            : Colors.white,
                        title: Row(
                          children: [
                            const Text('Clear wishlist! '),
                            Image.asset(
                              'assets/images/warning-sign.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            )
                          ],
                        ),
                        content: const Text('Your wishlist will be cleared!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: utils.blueColor),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              wishlistProvider.clearWishlist();
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(color: utils.redColor),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  IconlyBroken.delete,
                  color: utils.color,
                )),
          ),
        ],
      ),
      body: wishlistItemList.isEmpty
          ? const EmptyScreen(
              emptyText: 'You have not wishlisted any items',
              image: 'assets/images/wishlist.png',
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: 100 / 80,
              children: List.generate(wishlistItemList.length, (index) {
                return ChangeNotifierProvider.value(
                  value: wishlistItemList[index],
                  child: const WishlistWidget(
                      // q: cartItemsList[index].quantity,
                      ),
                );
              }),
            ),
    );
  }
}
