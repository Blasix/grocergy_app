import 'package:flutter/material.dart';

class AuthBTN extends StatelessWidget {
  const AuthBTN({Key? key, required this.fct, required this.btnText})
      : super(key: key);
  final Function fct;
  final String btnText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.white38),
          onPressed: () {
            fct();
          },
          child: Text(
            btnText,
            style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
