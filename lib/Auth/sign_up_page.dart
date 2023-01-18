import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/Auth/sign_in_page.dart';
import 'package:food_app/constant/color/colors.dart';
import 'dart:ui';

import 'package:food_app/constant/images/images.dart';
import 'package:food_app/pages/home/New_Home_Page.dart';
import 'package:food_app/pages/home/bottam_bar.dart';

import 'package:food_app/provider/user_provider.dart';
import 'package:food_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class sign_up_page extends StatefulWidget {
  const sign_up_page({Key? key}) : super(key: key);

  @override
  _sign_up_pageState createState() => _sign_up_pageState();
}

// ignore: camel_case_types
class _sign_up_pageState extends State<sign_up_page> {
  UserProvider? userProvider;
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final usercontroller = TextEditingController();
  final storage = new FlutterSecureStorage();
  final username = "";
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formkey,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height,
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
                          flex: 4,
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
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: App_Colors.white,
                                        ),
                                      ),
                                    ),
                                    component(
                                        Icons.account_circle_outlined,
                                        'User name',
                                        false,
                                        false,
                                        true,
                                        usercontroller),
                                    component(Icons.email_outlined, 'Email',
                                        false, true, true, _emailcontroller),
                                    component(Icons.lock_outline, 'Password',
                                        true, false, true, _passwordcontroller),
                                    Center(
                                      child: InkWell(
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
                                            text: 'Alredy have Account?',
                                            style: TextStyle(
                                              color: App_Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .006),
                                    InkWell(
                                      onTap: () async {
                                        if (_formkey.currentState!.validate()) {
                                          try {
                                            // ignore: unused_local_variable
                                            UserCredential userCredential =
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                                        email: _emailcontroller
                                                            .text,
                                                        password:
                                                            _passwordcontroller
                                                                .text);
                                            userProvider!.addUserData(
                                                currentUser:
                                                    userCredential.user,
                                                userEmail:
                                                    userCredential.user!.email,
                                                userImage:
                                                    "https://firebasestorage.googleapis.com/v0/b/foodapp-1234.appspot.com/o/EXTRA%2FUSER.png?alt=media&token=71a8b177-f884-4af3-9cb3-14a109f7542c",
                                                userName: usercontroller.text);
                                            await storage.write(
                                                key: "uid",
                                                value:
                                                    userCredential.user!.uid);
                                            Utils.showTopSnackBar(
                                                context,
                                                "User Created Successfully",
                                                Colors.green,
                                                150);
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
                                                    transitionsBuilder:
                                                        (context,
                                                            animation,
                                                            anotherAnimation,
                                                            child) {
                                                      animation =
                                                          CurvedAnimation(
                                                              curve: Curves
                                                                  .slowMiddle,
                                                              parent:
                                                                  animation);
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
                                              Utils.showTopSnackBar(
                                                  context,
                                                  "Password is Weak",
                                                  Colors.red,
                                                  80);
                                            } else if (e.code ==
                                                'email-already-in-use') {
                                              Utils.showTopSnackBar(
                                                  context,
                                                  "Email Already resgister",
                                                  Colors.red,
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
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          'Sign-Up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
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
      ),
    );
  }

  Widget component(IconData icon, String hintText, bool isPassword,
      bool isEmail, bool isuser, TextEditingController controller) {
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
          } else if (isuser) {
            if (value == null || value.isEmpty) {
              return 'Please enter UserName';
            }
            return null;
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: App_Colors.Auth_Filled,
          prefixIcon: Icon(
            icon,
            color: App_Colors.black,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          hintMaxLines: 1,
          hintText: hintText,
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 15),
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
