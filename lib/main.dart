import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: unused_import
import 'package:food_app/Auth/sign_in_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
// ignore: unused_import
import 'package:food_app/demo.dart';
import 'package:food_app/pages/Intro/flashscreen.dart';
import 'package:food_app/pages/Intro/flashscreen2.dart';
import 'package:food_app/pages/my_profile/My_order.dart';
import 'package:food_app/provider/All_order_provider.dart';

import 'package:food_app/provider/Checkout_Provider.dart';
import 'package:food_app/provider/my_oreder_provider.dart';
// ignore: unused_import
import 'package:food_app/provider/prmission.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:food_app/provider/wishList_Provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

// import 'pages/home/show_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

// Widget build(BuildContext context) {
//     return Provider<Example>(
//       create: (_) => Example(),
//       // we use `builder` to obtain a new `BuildContext` that has access to the provider
//       builder: (context) {
//         // No longer throws
//         return Text(context.watch<Example>()),
//       }
//     ),
//   }

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final storage = const FlutterSecureStorage();
  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductProvider>(
            create: (context) => ProductProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider<ReviewCartProvider>(
            create: (context) => ReviewCartProvider(),
          ),
          ChangeNotifierProvider<WishListProvider>(
            create: (context) => WishListProvider(),
          ),
          ChangeNotifierProvider<CheckoutProvider>(
            create: (context) => CheckoutProvider(),
          ),
          ChangeNotifierProvider<Myorder_Provider>(
            create: (context) => Myorder_Provider(),
          ),
          ChangeNotifierProvider<My_All_order_Provider>(
            create: (context) => My_All_order_Provider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Firestore CRUD',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          // ignore: prefer_const_constructors
          home: FutureBuilder(
              future: checkLoginStatus(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == false) {
                  return Flashscreen();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      color: Colors.white,
                      child: const Center(child: CircularProgressIndicator()));
                }
                return Flashscreen2();
              }),
          routes: {"myorder": (context) => MyOrder()},
        ),
      ),
    );
  }
}
