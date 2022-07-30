import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => getTheme ? Colors.white : Colors.black;
  Color get blueColor =>
      getTheme ? const Color.fromRGBO(13, 71, 161, 1) : Colors.blue;
  Color get redColor =>
      getTheme ? const Color.fromRGBO(183, 28, 28, 1) : Colors.red;
  Color get orangeColor =>
      getTheme ? const Color.fromRGBO(230, 81, 0, 1) : Colors.orange;
  Color get greenColor =>
      getTheme ? const Color.fromRGBO(27, 94, 32, 1) : Colors.green;

  Size get screenSize => MediaQuery.of(context).size;
}
