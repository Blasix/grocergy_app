import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../inner_screens/empty.dart';
import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/cart_widget.dart';
import '../widgets/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    bool isEmpty = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Cart (items)',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
        actions: [
          Visibility(
            visible: !isEmpty,
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
                            const Text('Clear cart! '),
                            Image.asset(
                              'assets/images/warning-sign.png',
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            )
                          ],
                        ),
                        content: const Text('Your cart will be cleared!'),
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
                            onPressed: () {},
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
      body: isEmpty
          ? const EmptyScreen(
              emptyText: 'There are no items in your cart',
              image: 'assets/images/cart.png',
            )
          : Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: utils.screenSize.height * 0.08,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        Material(
                          color: utils.blueColor,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextWidget(
                                text: 'Order Now',
                                color: utils.color,
                                textSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextWidget(
                            text: 'Total: price',
                            color: utils.color,
                            textSize: 22)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, index) {
                        return const CartWidget();
                      }),
                ),
              ],
            ),
    );
  }
}
