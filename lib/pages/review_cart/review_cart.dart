import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Review_cart.dart';
import 'package:food_app/pages/CheckOut/Delivery%20Detail/Delivery_Detail.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/widgets/singel_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ReviewCart extends StatelessWidget {
  const ReviewCart({Key? key, this.isover}) : super(key: key);
  final bool? isover;
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    Size size = MediaQuery.of(context).size;
    List<dynamic> productunit = ['250 Gram', '500 Gram', '1 Kg'];

    return Scaffold(
      extendBody: true,
      backgroundColor: App_Colors.ScafoldeColor,
      bottomNavigationBar: Container(
        margin: isover == false
            ? EdgeInsets.symmetric(vertical: size.height * .1)
            : EdgeInsets.symmetric(vertical: size.height * .0),
        child: ListTile(
          title: Container(
            height: size.height * .06,
            decoration: BoxDecoration(
                color: App_Colors.Primary_Color,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * .05,
                top: size.height * .007,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "₹${reviewCartProvider.getTotalPrice()}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          trailing: Container(
            width: 160,
            child: MaterialButton(
              child: Text(
                "Submit",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: App_Colors.white),
              ),
              color: App_Colors.Primary_Color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              onPressed: () {
                if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                  Fluttertoast.showToast(msg: "No Cart Data Found");
                } else
                  // ignore: curly_braces_in_flow_control_structures
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeliveryDetails(),
                    ),
                  );
              },
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Review Cart"),
        backgroundColor: App_Colors.Primary_Color,
      ),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
              child: Text("NO DATA"),
            )
          : AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: reviewCartProvider.reviewCartDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  ReviewCartModel data =
                      reviewCartProvider.getReviewCartDataList[index];
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
                            Singel_item(
                              wishlist: false,
                              deleteWishlist: false,
                              isbool: true,
                              issearch: false,
                              productUnitList: productunit,
                              productImage: data.cartImage!,
                              productName: data.cartName!,
                              productPrice: data.cartPrice!,
                              // productDescription: data.description,
                              productId: data.cartId!,
                              productQuantity: data.cartQuantity!,
                              productUnit: data.cartunit,
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
