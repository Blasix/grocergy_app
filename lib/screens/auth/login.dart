import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:grocery/screens/auth/forgot_pass.dart';
import 'package:grocery/screens/auth/register.dart';
import 'package:grocery/services/global_methods.dart';
import 'package:grocery/services/utils.dart';
import 'package:grocery/widgets/apple_btn.dart';
import 'package:grocery/widgets/text_widget.dart';

import '../../constants/consts.dart';
import '../../widgets/auth_btn.dart';
import '../../widgets/google_btn.dart';
import '../btm_bar.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnLogin() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
              duration: 1200,
              autoplayDelay: 6000,
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Consts.authImages[index],
                  fit: BoxFit.fitHeight,
                );
              },
              itemCount: Consts.authImages.length),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Utils(context).screenSize.height * 0.08,
                    ),
                    TextWidget(
                      text: 'Welcome back!',
                      color: Colors.white,
                      textSize: 30,
                      isTitle: true,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      text: 'Sign in to continue',
                      color: Colors.white,
                      textSize: 18,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            cursorColor: Utils(context).blueColor,
                            controller: _emailTextController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
                            validator: ValidationBuilder()
                                .email()
                                .maxLength(50)
                                .build(),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.mail, color: Colors.grey),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Email",
                              hintStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Utils(context).blueColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Utils(context).redColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Utils(context).blueColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onEditingComplete: () {
                              _submitFormOnLogin();
                            },
                            cursorColor: Utils(context).blueColor,
                            focusNode: _passFocusNode,
                            controller: _passTextController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            validator: ValidationBuilder()
                                .minLength(5)
                                .maxLength(20)
                                .regExp(RegExp('(?=.*?[A-Z])'),
                                    'Must contain at least one uppercase letter')
                                .regExp(RegExp('(?=.*?[0-9])'),
                                    'Must contain at least one number')
                                .build(),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.vpn_key, color: Colors.grey),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Utils(context).blueColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Utils(context).redColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 3, color: Utils(context).blueColor),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: _obscureText
                                    ? const Icon(Icons.visibility,
                                        color: Colors.grey)
                                    : const Icon(Icons.visibility_off,
                                        color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            GlobalMethods.navigateTo(
                                ctx: context,
                                routeName: ForgotPassScreen.routeName);
                          },
                          child: const Text(
                            'Forgot password?',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          )),
                    ),
                    AuthBTN(
                      btnText: 'Sign in',
                      fct: () {
                        _submitFormOnLogin();
                      },
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const GoogleBTN(),
                    const SizedBox(
                      height: 10,
                    ),
                    const AppleBTN(),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextWidget(
                          text: 'OR',
                          color: Colors.grey,
                          textSize: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AuthBTN(
                        fct: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const BottomBarScreen(),
                            ),
                          );
                        },
                        btnText: 'Continue as a guest'),
                    Row(
                      children: [
                        const Text(
                          "Don't have an account?",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: const Text(
                              'Sign up',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
