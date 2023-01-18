import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/Auth/forget_password_page.dart';
import 'package:food_app/Auth/sign_up_page.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/constant/images/images.dart';
import 'package:food_app/pages/home/New_Home_Page.dart';
import 'package:food_app/pages/home/bottam_bar.dart';

import 'package:food_app/pages/home/main_Page.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:food_app/widgets/snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types5
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

// ignore: camel_case_types
class _SignInPageState extends State<SignInPage> {
  UserProvider? userProvider;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  // ignore: unused_field
  final _usercontroller = TextEditingController();
  bool islogin = true;

  Future<User?> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      userProvider!.addUserData(
          currentUser: user!,
          userName: user.displayName!,
          userEmail: user.email!,
          userImage: user.photoURL!);
      await storage.write(key: "uid", value: user.uid);
      return user;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  final storage = new FlutterSecureStorage();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
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
                    height: size.height,
                    child: Image(
                      image: NetworkImage(
                        Images.sign_in_image,
                      ),
                      fit: BoxFit.cover,
                    )),
                Center(
                  child: Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Expanded(
                        flex: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
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
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: App_Colors.white,
                                      ),
                                    ),
                                  ),
                                  component(Icons.email_outlined, 'Email',
                                      false, true, _emailcontroller),
                                  component(Icons.lock_outline, 'Password',
                                      true, false, _passwordcontroller),
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
                                                    return const forget_password_page();
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
                                            text: 'Forgotten password!',
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
                                              .1),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _googleSignUp().then((value) => Navigator
                                              .of(context)
                                          .push(PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  anotherAnimation) {
                                                return Home2();
                                              },
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 1000),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  anotherAnimation,
                                                  child) {
                                                animation = CurvedAnimation(
                                                    curve: Curves.slowMiddle,
                                                    parent: animation);
                                                return Align(
                                                  child: SizeTransition(
                                                    sizeFactor: animation,
                                                    child: child,
                                                    axisAlignment: 0.0,
                                                  ),
                                                );
                                              })));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        // color: Colors.black.withOpacity(.1),
                                        color: App_Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 15,
                                            child: Image(
                                              image: AssetImage(
                                                  Images.Google_logo),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .02,
                                          ),
                                          Text(
                                            "Login with Google",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: App_Colors.black,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (_formkey.currentState!.validate()) {
                                        try {
                                          // ignore: unused_local_variable
                                          UserCredential userCredential =
                                              await FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(
                                                      email:
                                                          _emailcontroller.text,
                                                      password:
                                                          _passwordcontroller
                                                              .text);
                                          await storage.write(
                                              key: "uid",
                                              value: userCredential.user!.uid);
                                          Navigator.of(context).push(
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                      animation,
                                                      anotherAnimation) {
                                                    return Home2();
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
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'weak-password') {
                                            // ignore: avoid_print
                                            print(
                                                'The password provided is too weak.');
                                          } else if (e.code ==
                                              'wrong-password') {
                                            Utils.showTopSnackBar(
                                                context,
                                                "Wrong Password Provided by User",
                                                Colors.red,
                                                80);
                                          } else {
                                            Utils.showTopSnackBar(
                                                context,
                                                "Please Create Account",
                                                Colors.blueAccent,
                                                80);
                                          }
                                        } catch (e) {
                                          // ignore: avoid_print
                                          print(e);
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        // color: Colors.black.withOpacity(.1),
                                        color: App_Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Sing-In',
                                        style: TextStyle(
                                          color: App_Colors.white,
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
                      // Expanded(
                      //   child: SizedBox(),
                      // ),
                      const Expanded(child: SizedBox())
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
          } else if (isPassword) {
            if (value == null || value.isEmpty) {
              return 'Please enter password';
            }
            return null;
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          // fillColor: Colors.black.withOpacity(.1),
          fillColor: App_Colors.Auth_Filled,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          prefixIcon: Icon(
            icon,
            // color: Colors.white.withOpacity(.8),
            color: App_Colors.black,
          ),
          hintMaxLines: 1,
          hintText: hintText,
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 15),
          hintStyle: TextStyle(
              fontSize: 14,
              // color: Colors.white.withOpacity(.5),
              color: App_Colors.black),
        ),
      ),
    );
  }
}
