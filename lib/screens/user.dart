import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/user_screens/orders.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/user_screens/viewed.dart';
import 'package:grocery/user_screens/wishlist.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/utils.dart';
import '../user_screens/viewed.dart';
import '../widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Hi, ',
                      style: TextStyle(
                        color: color,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Name',
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextWidget(
                    text: 'Email',
                    color: color,
                    textSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                _listTiles(
                  title: 'Address',
                  subtitle: 'your address',
                  icon: IconlyLight.profile,
                  onPressed: () {
                    _showAddressDialog();
                  },
                  color: color,
                ),
                _listTiles(
                  title: 'Orders',
                  icon: IconlyLight.bag,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: OrdersScreen.routeName);
                  },
                  color: color,
                ),
                _listTiles(
                  title: 'Wishlist',
                  icon: IconlyLight.heart,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: WishlistScreen.routeName);
                  },
                  color: color,
                ),
                _listTiles(
                  title: 'Viewed',
                  icon: IconlyLight.show,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: ViewedScreen.routeName);
                  },
                  color: color,
                ),
                _listTiles(
                  title: 'Forgot password',
                  icon: IconlyLight.lock,
                  onPressed: () {},
                  color: color,
                ),
                _listTiles(
                  title: 'Logout',
                  icon: IconlyLight.logout,
                  onPressed: () {
                    _showLogoutDialog();
                  },
                  color: color,
                ),
                SwitchListTile(
                  activeColor:
                      themeState.getDarkTheme ? Colors.blue[900] : Colors.blue,
                  title: TextWidget(
                    text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                    color: color,
                    textSize: 22,
                  ),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  value: themeState.getDarkTheme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          final themeState = Provider.of<DarkThemeProvider>(context);
          final utils = Utils(context);
          return AlertDialog(
            backgroundColor: themeState.getDarkTheme
                ? Theme.of(context).cardColor
                : Colors.white,
            title: const Text('Update'),
            content: TextField(
              // onChanged: (value) {
              //   print(
              //       '_addressTextController.text ${_addressTextController.text}');
              // },
              controller: _addressTextController,
              // maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Update',
                  style: TextStyle(color: utils.blueColor),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showLogoutDialog() async {
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
                const Text('Sign out '),
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                )
              ],
            ),
            content: const Text('Do you wanna sign out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: utils.blueColor),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sign out',
                  style: TextStyle(color: utils.redColor),
                ),
              ),
            ],
          );
        });
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
      ),
      subtitle: Text(subtitle ?? ""),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
