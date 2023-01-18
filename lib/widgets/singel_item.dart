import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/Review_cart.dart';
import 'package:food_app/pages/home/New_Home_Page.dart';
import 'package:food_app/pages/product/overe.dart';
import 'package:food_app/provider/review_cart_provider.dart';
import 'package:food_app/provider/wishList_Provider.dart';
import 'package:food_app/widgets/count.dart';
import 'package:provider/provider.dart';

class Singel_item extends StatefulWidget {
  Singel_item(
      {Key? key,
      required this.isbool,
      required this.productImage,
      required this.productName,
      // ignore: non_constant_identifier_names
      required this.productPrice,
      required this.productId,
      required this.productQuantity,
      required this.wishlist,
      required this.deleteWishlist,
      required this.issearch,
      this.productUnit,
      required this.productUnitList,
      this.productDescription})
      : super(key: key);
  final bool isbool;
  final String productImage;
  final String productName;
  // ignore: non_constant_identifier_names
  final num productPrice;
  final String productId;
  final int productQuantity;
  final bool wishlist;
  final bool deleteWishlist;
  final bool issearch;
  final String? productDescription;
  var productUnit;
  final List productUnitList;

  @override
  State<Singel_item> createState() => _Singel_itemState();
}

class _Singel_itemState extends State<Singel_item> {
  ReviewCartProvider? reviewCartProvider;
  WishListProvider? wishListProvider;
  List<dynamic> productunit = ['250 Gram', '500 Gram', '1 Kg'];
  String? unitdata;
  var firstValue;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        widget.deleteWishlist == true
            ? wishListProvider?.deleteWishtList(widget.productId)
            : reviewCartProvider?.reviewCartDataDelete(widget.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  late int counts;

  getCount() {
    setState(() {
      counts = widget.productQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.productUnitList.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    getCount();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    Size size = MediaQuery.of(context).size;
    return widget.issearch
        ? gester(context, size, reviewCartProvider)
        : Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            // elevation: 50,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: size.height * .120,
                      child: Image(image: NetworkImage(widget.productImage)),
                    )),
                    Expanded(
                        child: Container(
                      height: size.height * .120,
                      child: Column(
                        mainAxisAlignment: widget.isbool == false
                            ? MainAxisAlignment.spaceAround
                            : MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "₹${widget.productPrice} ",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          widget.isbool == false
                              ? InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            Colors.transparent.withOpacity(0),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(40),
                                                )),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: widget.productUnitList
                                                  .map((data) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: size
                                                                      .height *
                                                                  .02,
                                                              horizontal:
                                                                  size.width *
                                                                      .01),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            unitdata = data!;
                                                          });

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          data,
                                                          style: TextStyle(
                                                              color: App_Colors
                                                                  .Primary_Color,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                );
                                              }).toList(),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: MediaQuery.of(context).size.height *
                                        .035,
                                    width:
                                        MediaQuery.of(context).size.width * .29,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 204, 201, 201),
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 56, 54, 54)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            unitdata ?? firstValue,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 10, 10, 10),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                            color: App_Colors.Primary_Color,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Text(widget.productUnit)
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                            height: size.height * .1,
                            padding: widget.isbool == false
                                ? EdgeInsets.symmetric(
                                    horizontal: size.width * .06,
                                    vertical: size.height * .0350)
                                : EdgeInsets.only(
                                    left: size.width * .0,
                                    right: size.width * .0),
                            child: widget.isbool == false
                                ? count(
                                    productId: widget.productId,
                                    productImage: widget.productImage,
                                    productName: widget.productName,
                                    productPrice: widget.productPrice,
                                    productUnit: unitdata ?? firstValue,
                                    // productQuantity: "1",
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * .004),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * .03,
                                        ),
                                        widget.wishlist == false
                                            ? Container(
                                                height: size.height * .03,
                                                width: size.width * .210,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  // color: Colors.black,
                                                  border: Border.all(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .00150,
                                                    color: App_Colors.black,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (counts == 1) {
                                                            reviewCartProvider
                                                                .reviewCartDataDelete(
                                                                    widget
                                                                        .productId);
                                                          } else {
                                                            setState(() {
                                                              counts--;
                                                            });
                                                            reviewCartProvider
                                                                .updateReviewCartData(
                                                              cartImage: widget
                                                                  .productImage,
                                                              cartId: widget
                                                                  .productId,
                                                              cartName: widget
                                                                  .productName,
                                                              cartPrice: widget
                                                                  .productPrice,
                                                              cartQuantity:
                                                                  counts,
                                                            );
                                                          }
                                                        },
                                                        child: counts == 1
                                                            ? Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              )
                                                            : Icon(
                                                                Icons.remove,
                                                                size: 20,
                                                                color: App_Colors
                                                                    .Primary_Color,
                                                              ),
                                                      ),
                                                      Text(
                                                        "$counts",
                                                        style: TextStyle(
                                                            color: App_Colors
                                                                .Primary_Color),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (counts < 10) {
                                                            setState(() {
                                                              counts++;
                                                            });
                                                            reviewCartProvider
                                                                .updateReviewCartData(
                                                              cartImage: widget
                                                                  .productImage,
                                                              cartId: widget
                                                                  .productId,
                                                              cartName: widget
                                                                  .productName,
                                                              cartPrice: widget
                                                                  .productPrice,
                                                              cartQuantity:
                                                                  counts,
                                                            );
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 20,
                                                          color: App_Colors
                                                              .Primary_Color,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ))),
                  ],
                ),
                // widget.isbool == false
                //     ? Container()
                //     : const Divider(
                //         height: 1,
                //         color: Colors.black,
                //       ),
              ],
            ),
          );
  }

  GestureDetector gester(
      BuildContext context, Size size, ReviewCartProvider reviewCartProvider) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Screen2(
                      productId: widget.productId,
                      productUnit: productunit,
                      productImage: widget.productImage,
                      productName: widget.productName,
                      productPrice: widget.productPrice,
                      productDescription: widget.productDescription!,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // elevation: 50,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: size.height * .120,
                  child: Image(image: NetworkImage(widget.productImage)),
                )),
                Expanded(
                    child: Container(
                  height: size.height * .120,
                  child: Column(
                    mainAxisAlignment: widget.isbool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "₹${widget.productPrice} ",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      widget.isbool == false
                          ? InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor:
                                        Colors.transparent.withOpacity(0),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(40),
                                            )),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: widget.productUnitList
                                              .map((data) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          size.height * .02,
                                                      horizontal:
                                                          size.width * .01),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        unitdata = data!;
                                                      });

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      data,
                                                      style: TextStyle(
                                                          color: App_Colors
                                                              .Primary_Color,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.black,
                                                )
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height:
                                    MediaQuery.of(context).size.height * .035,
                                width: MediaQuery.of(context).size.width * .3,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 204, 201, 201),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 56, 54, 54)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        unitdata ?? firstValue,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 10, 10, 10),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 30,
                                        color: App_Colors.Primary_Color,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Text(widget.productUnit)
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                        height: size.height * .1,
                        padding: widget.isbool == false
                            ? EdgeInsets.symmetric(
                                horizontal: size.width * .06,
                                vertical: size.height * .0350)
                            : EdgeInsets.only(
                                left: size.width * .0, right: size.width * .0),
                        child: widget.isbool == false
                            ? count(
                                productId: widget.productId,
                                productImage: widget.productImage,
                                productName: widget.productName,
                                productPrice: widget.productPrice,
                                productUnit: unitdata ?? firstValue,
                                // productQuantity: "1",
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * .004),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * .03,
                                    ),
                                    widget.wishlist == false
                                        ? Container(
                                            height: size.height * .03,
                                            width: size.width * .210,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              // color: Colors.black,
                                              border: Border.all(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .00150,
                                                color: App_Colors.black,
                                              ),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (counts == 1) {
                                                        reviewCartProvider
                                                            .reviewCartDataDelete(
                                                                widget
                                                                    .productId);
                                                      } else {
                                                        setState(() {
                                                          counts--;
                                                        });
                                                        reviewCartProvider
                                                            .updateReviewCartData(
                                                          cartImage: widget
                                                              .productImage,
                                                          cartId:
                                                              widget.productId,
                                                          cartName: widget
                                                              .productName,
                                                          cartPrice: widget
                                                              .productPrice,
                                                          cartQuantity: counts,
                                                        );
                                                      }
                                                    },
                                                    child: counts == 1
                                                        ? Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                          )
                                                        : Icon(
                                                            Icons.remove,
                                                            size: 20,
                                                            color: App_Colors
                                                                .Primary_Color,
                                                          ),
                                                  ),
                                                  Text(
                                                    "$counts",
                                                    style: TextStyle(
                                                        color: App_Colors
                                                            .Primary_Color),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (counts < 10) {
                                                        setState(() {
                                                          counts++;
                                                        });
                                                        reviewCartProvider
                                                            .updateReviewCartData(
                                                          cartImage: widget
                                                              .productImage,
                                                          cartId:
                                                              widget.productId,
                                                          cartName: widget
                                                              .productName,
                                                          cartPrice: widget
                                                              .productPrice,
                                                          cartQuantity: counts,
                                                        );
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 20,
                                                      color: App_Colors
                                                          .Primary_Color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ))),
              ],
            ),
            // widget.isbool == false
            //     ? Container()
            //     : const Divider(
            //         height: 1,
            //         color: Colors.black,
            //       ),
          ],
        ),
      ),
    );
  }
}
