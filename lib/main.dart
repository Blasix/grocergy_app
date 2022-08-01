import 'package:flutter/material.dart';
import 'package:grocery/inner_screens/feeds.dart';
import 'package:grocery/inner_screens/on_sale.dart';
import 'package:grocery/inner_screens/product_details.dart';
import 'package:grocery/screens/auth/forgot_pass.dart';
import 'package:grocery/screens/auth/login.dart';
import 'package:grocery/screens/auth/register.dart';
import 'package:grocery/user_screens/orders.dart';
import 'package:grocery/provider/dark_theme_provider.dart';
import 'package:grocery/screens/btm_bar.dart';
import 'package:grocery/user_screens/viewed.dart';
import 'package:grocery/user_screens/wishlist.dart';
import 'package:provider/provider.dart';

import 'constants/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const LoginScreen(),
          routes: {
            OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
            FeedsScreen.routeName: (ctx) => const FeedsScreen(),
            ProductDetails.routeName: (ctx) => const ProductDetails(),
            WishlistScreen.routeName: (ctx) => const WishlistScreen(),
            OrdersScreen.routeName: (ctx) => const OrdersScreen(),
            ViewedScreen.routeName: (ctx) => const ViewedScreen(),
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            ForgotPassScreen.routeName: (ctx) => const ForgotPassScreen(),
          },
        );
      }),
    );
  }
}
