import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:form_validator/form_validator.dart';
import 'package:grocery/constants/firebase_consts.dart';
import 'package:grocery/screens/loading_manager.dart';
import 'package:grocery/services/global_methods.dart';

import '../../constants/consts.dart';
import '../../services/utils.dart';
import '../../widgets/auth_btn.dart';
import '../../widgets/text_widget.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);
  static const routeName = "/ForgotPassScreen";

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  Future<void> _submitFormOnLogin(context) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailTextController.text.toLowerCase().trim());
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Send!',
            message: 'A reset password email hasbeen succesfully send',
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on FirebaseAuthException catch (error) {
        GlobalMethods.dialog(
          context: context,
          title: 'On snap!',
          message: '${error.message}',
          contentType: ContentType.failure,
        );
        setState(() {
          _isLoading = false;
        });
        return;
      } catch (error) {
        GlobalMethods.dialog(
          context: context,
          title: 'On snap!',
          message: '$error',
          contentType: ContentType.failure,
        );
        setState(() {
          _isLoading = false;
        });
        return;
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
                        height: Utils(context).screenSize.height * 0.01,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null;
                        },
                        child: const Icon(
                          IconlyLight.arrowLeft2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: Utils(context).screenSize.height * 0.04,
                      ),
                      TextWidget(
                        text: 'Forgot Password',
                        color: Colors.white,
                        textSize: 30,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextWidget(
                        text: 'Enter email to reset password',
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
                              onEditingComplete: () {
                                _submitFormOnLogin(context);
                              },
                              cursorColor: Utils(context).blueColor,
                              controller: _emailTextController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
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
                            AuthBTN(
                              btnText: 'Reset now',
                              fct: () {
                                _submitFormOnLogin(context);
                              },
                            ),
                          ],
                        ),
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
