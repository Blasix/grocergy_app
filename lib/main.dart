import 'package:flutter/material.dart';
import 'package:grocery/screens/home.dart';

import 'consts/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Styles.themeData(false, context),
      home: const Home(),
    );
  }
}
