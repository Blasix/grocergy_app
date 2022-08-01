import 'package:flutter/material.dart';

class AppleBTN extends StatelessWidget {
  const AppleBTN({Key? key}) : super(key: key);

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
                  'assets/images/apple.png',
                  height: 36,
                ),
                Text(
                  '  Sign in with Apple',
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
