import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
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
                RichText(
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
                TextWidget(
                  text: 'Email',
                  color: color,
                  textSize: 18,
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
                  onPressed: () {},
                  color: color,
                ),
                _listTiles(
                  title: 'Wishlist',
                  icon: IconlyLight.heart,
                  onPressed: () {},
                  color: color,
                ),
                _listTiles(
                  title: 'Viewed',
                  icon: IconlyLight.show,
                  onPressed: () {},
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
                  style: TextStyle(
                    color: themeState.getDarkTheme
                        ? Colors.blue[900]
                        : Colors.blue,
                  ),
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
          return AlertDialog(
            backgroundColor: themeState.getDarkTheme
                ? Theme.of(context).cardColor
                : Colors.white,
            title: Row(
              children: [
                const Text('Sign out '),
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                )
              ],
            ),
            content: const Text('Do you wanna Sing out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: themeState.getDarkTheme
                        ? Colors.blue[900]
                        : Colors.blue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sing out',
                  style: TextStyle(
                    color:
                        themeState.getDarkTheme ? Colors.red[900] : Colors.red,
                  ),
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
