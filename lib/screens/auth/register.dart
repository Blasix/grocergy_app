import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:grocery/constants/firebase_consts.dart';
import 'package:grocery/screens/auth/login.dart';
import 'package:grocery/screens/btm_bar.dart';
import 'package:grocery/screens/loading_manager.dart';

import '../../constants/consts.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widgets/auth_btn.dart';
import '../../widgets/text_widget.dart';
import 'forgot_pass.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _adressTextController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _adressFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _adressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _adressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomBarScreen(),
          ),
        );
      } on FirebaseAuthException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
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
                        text: 'Welcome',
                        color: Colors.white,
                        textSize: 30,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextWidget(
                        text: 'Sign up to continue',
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
                              controller: _nameTextController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              validator: ValidationBuilder().build(),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.grey),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Full name",
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Utils(context).blueColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3, color: Utils(context).redColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Utils(context).blueColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Utils(context).blueColor,
                              focusNode: _emailFocusNode,
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
                                      width: 3,
                                      color: Utils(context).blueColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3, color: Utils(context).redColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Utils(context).blueColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_adressFocusNode),
                              textInputAction: TextInputAction.next,
                              cursorColor: Utils(context).blueColor,
                              focusNode: _passFocusNode,
                              controller: _passTextController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              validator: ValidationBuilder()
                                  .minLength(6)
                                  .maxLength(20)
                                  .regExp(RegExp('(?=.*?[A-Z])'),
                                      'Must contain at least one uppercase letter')
                                  .regExp(RegExp('(?=.*?[0-9])'),
                                      'Must contain at least one number')
                                  .build(),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.vpn_key,
                                    color: Colors.grey),
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
                                      width: 3,
                                      color: Utils(context).blueColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3, color: Utils(context).redColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Utils(context).blueColor),
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
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              focusNode: _adressFocusNode,
                              cursorColor: Utils(context).blueColor,
                              controller: _adressTextController,
                              keyboardType: TextInputType.streetAddress,
                              onEditingComplete: () {
                                _submitFormOnLogin();
                              },
                              validator: ValidationBuilder().build(),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.home, color: Colors.grey),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                hintText: "Shipping adress",
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Utils(context).blueColor),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3, color: Utils(context).redColor),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 3,
                                      color: Utils(context).blueColor),
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
                      const SizedBox(
                        height: 0,
                      ),
                      AuthBTN(
                        btnText: 'Sign up',
                        fct: () {
                          _submitFormOnLogin();
                        },
                      ),
                      Row(
                        children: [
                          const Text(
                            "Already a user?",
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: const Text(
                                'Sign in',
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
      ),
    );
  }
}
