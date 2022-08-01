import 'package:flutter/material.dart';

class GoogleBTN extends StatelessWidget {
  const GoogleBTN({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.white38),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google.png',
                  height: 36,
                ),
                Text(
                  '  Sign in with Google',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )),
    );
  }
}
