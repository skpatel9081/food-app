import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:provider/provider.dart';

class count extends StatefulWidget {
  count({
    Key? key,
    this.productName,
    this.productImage,
    this.productId,
    // this.productQuantity,
    this.productPrice,
    this.productUnit,
  }) : super(key: key);
  final String? productName;
  final String? productImage;

  final String? productId;
  var productUnit;
  // final String? productQuantity;
  final num? productPrice;
  @override
  State<count> createState() => _countState();
}

class _countState extends State<count> {
  int count = 1;
  bool isTrue = false;
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviwCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviwCart")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        count = value.get("cartQuantity");
                        isTrue = value.get("isAdd");
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
        height: MediaQuery.of(context).size.height * 0.03,
        width: MediaQuery.of(context).size.width * .150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: MediaQuery.of(context).size.width * .00150,
              color: Colors.black,
            )),
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // const box(width: .04),
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          isTrue = false;
                        });
                        reviewCartProvider
                            .reviewCartDataDelete(widget.productId);
                      }
                      if (count > 1) {
                        setState(() {
                          count--;
                        });
                        reviewCartProvider.updateReviewCartData(
                          cartId: widget.productId,
                          cartImage: widget.productImage,
                          cartName: widget.productName,
                          cartPrice: widget.productPrice,
                          cartQuantity: count,
                        );
                      }
                    },
                    child: Icon(
                      Icons.remove,
                      color: App_Colors.Primary_Color,
                      size: 16,
                    ),
                  ),

                  Text(
                    "$count",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: App_Colors.Primary_Color,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: App_Colors.Primary_Color,
                      size: 18,
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addUReviewCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                      cartUnit: widget.productUnit);
                },
                child: Center(
                  child: Text(
                    "ADD",
                    style: TextStyle(color: App_Colors.Primary_Color),
                  ),
                ),
              ));
  }
}
