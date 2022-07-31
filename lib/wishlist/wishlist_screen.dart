import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../widgets/back_widget.dart';
import '../widgets/text_widget.dart';
import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Wishlist (items)',
          color: utils.color,
          textSize: 24,
          isTitle: true,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    final themeState = Provider.of<DarkThemeProvider>(context);
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
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        childAspectRatio: 40 / 30,
        children: List.generate(16, (index) {
          return const WishlistWidget();
        }),
      ),
    );
  }
}
