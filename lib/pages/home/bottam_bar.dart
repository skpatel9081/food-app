import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/Wish_List/Wish_List.dart';
import 'package:food_app/pages/home/New_Home_Page.dart';
import 'package:food_app/pages/my_profile/my_profile.dart';
import 'package:food_app/pages/review_cart/review_cart.dart';
import 'package:food_app/pages/search/Search.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int index = 0;
  final items = <Widget>[
    const Icon(
      Icons.home,
      size: 25,
    ),
    const Icon(
      Icons.favorite,
      size: 25,
    ),
    const Icon(
      Icons.shop,
      size: 25,
    ),
    const Icon(
      Icons.person,
      size: 25,
    ),
  ];

  int currentindex = 0;
  final screen = [
    Home_Page1(),
    WishList(),
    ReviewCart(isover: false),
    MyProfile()
  ];
  ProductProvider? productProvider;
  @override
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchHerbsProductData();
    productProvider.fatchFreshProductData();
    productProvider.fatchRootProductData();
    super.initState();
  }

  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      extendBody: true,
      body: screen[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          // height: 70,
          color: Colors.black,
          // color: App_Colors.Primary_Color,
          animationCurve: Curves.bounceOut,
          animationDuration: const Duration(microseconds: 300),
          items: items,
          index: index,
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }
}
