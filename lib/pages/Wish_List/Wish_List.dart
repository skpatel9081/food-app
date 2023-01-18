import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Review_cart.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/provider/wishList_Provider.dart';
import 'package:food_app/widgets/singel_item.dart';
import 'package:food_app/widgets/wishlist_iteam.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  // WishListProvider? wishListProvider;
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListProvider? wishListProvider;
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    WishListProvider wishListProvider = Provider.of(context);
    wishListProvider.getWishtListData();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: App_Colors.ScafoldeColor,
      appBar: AppBar(
        title: const Text("WishList"),
        backgroundColor: App_Colors.Primary_Color,
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: wishListProvider.wishList.length,
          itemBuilder: (BuildContext context, int index) {
            ProductModel data = wishListProvider.getWishList[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 2500),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Wishlist_Iteam(
                        productImage: data.productImage,
                        productName: data.productName,
                        productPrice: data.productPrice,
                        productUnit: data.unit!,
                        productId: data.productId,
                        productDescription: data.productDescription,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
// ListView.builder(
//           itemCount: wishListProvider.wishList.length,
//           itemBuilder: (context, index) {
//             ProductModel data = wishListProvider.getWishList[index];
//             return Column(
//               children: [
//                 SizedBox(
//                   height: size.height * .01,
//                 ),
//                 Wishlist_Iteam(
//                   productImage: data.productImage,
//                   productName: data.productName,
//                   productPrice: data.productPrice,
//                   productUnit: data.unit!,
//                   productId: data.productId,
//                   productDescription: data.productDescription,
//                 ),
//               ],
//             );
//           }),