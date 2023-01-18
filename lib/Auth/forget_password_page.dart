import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:food_app/Auth/sign_in_page.dart';
import 'package:food_app/Auth/sign_up_page.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/constant/images/images.dart';
import 'package:food_app/widgets/snackbar.dart';

// ignore: camel_case_types
class forget_password_page extends StatefulWidget {
  const forget_password_page({Key? key}) : super(key: key);

  @override
  _forget_password_pageState createState() => _forget_password_pageState();
}

// ignore: camel_case_types
class _forget_password_pageState extends State<forget_password_page> {
  final _formkey = GlobalKey<FormState>();
  var emailAuth = 'someemail@domain.com';

  final _emailcontroller = TextEditingController();
  // ignore: unused_field
  final _usercontroller = TextEditingController();
  bool islogin = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height * 1,
                  child: Image.network(
                    Images.sign_in_image,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      bottom: size.width * .1,
                                    ),
                                    child: Text(
                                      'Forget Password',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: App_Colors.white,
                                      ),
                                    ),
                                  ),
                                  component(Icons.email_outlined, 'Email',
                                      false, true, _emailcontroller),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.height *
                                  //       .02,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      anotherAnimation) {
                                                    return const SignInPage();
                                                  },
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      anotherAnimation,
                                                      child) {
                                                    animation = CurvedAnimation(
                                                        curve:
                                                            Curves.easeInBack,
                                                        parent: animation);
                                                    return Align(
                                                      child: SizeTransition(
                                                        sizeFactor: animation,
                                                        child: child,
                                                        axisAlignment: 0.0,
                                                      ),
                                                    );
                                                  }));
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Login',
                                            style: TextStyle(
                                              color: App_Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      anotherAnimation) {
                                                    return const sign_up_page();
                                                  },
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 1000),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      anotherAnimation,
                                                      child) {
                                                    animation = CurvedAnimation(
                                                        curve:
                                                            Curves.slowMiddle,
                                                        parent: animation);
                                                    return Align(
                                                      child: SizeTransition(
                                                        sizeFactor: animation,
                                                        child: child,
                                                        axisAlignment: 0.0,
                                                      ),
                                                    );
                                                  }));
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Create a new Account',
                                            style: TextStyle(
                                              color: App_Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .03),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (_formkey.currentState!.validate()) {
                                        try {
                                          await FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                                  email: _emailcontroller.text);
                                          Utils.showTopSnackBar(
                                              context,
                                              "Password Reset Email has been  sent !",
                                              Colors.green,
                                              80);
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            Utils.showTopSnackBar(
                                                context,
                                                "User not register",
                                                Colors.red,
                                                80);
                                          }
                                          // ignore: empty_catches
                                        } catch (e) {}
                                        // }
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .02,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: App_Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Send Email',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              .01),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * .05,
        right: MediaQuery.of(context).size.width * .05,
      ),
      child: TextFormField(
        style: TextStyle(
          color: App_Colors.black,
        ),
        obscureText: isPassword,
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        autofocus: false,
        validator: (value) {
          if (isEmail) {
            if (value == null || value.isEmpty) {
              return 'Please enter email';
            } else if (!value.contains('@')) {
              return 'Please enter valid email';
            }
            return null;
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          filled: true,
          fillColor: App_Colors.Auth_Filled,
          prefixIcon: Icon(
            icon,
            color: App_Colors.black,
          ),
          hintMaxLines: 1,
          hintText: hintText,
          // ignore: prefer_const_constructors
          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
          hintStyle: TextStyle(
            fontSize: 14,
            color: App_Colors.black,
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
