import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/review_cart/review_cart.dart';
import 'package:food_app/provider/wishList_Provider.dart';
import 'package:food_app/widgets/count.dart';
import 'package:provider/provider.dart';

class Screen2 extends StatefulWidget {
  const Screen2(
      {Key? key,
      this.productName,
      this.productImage,
      this.productPrice,
      this.productId,
      required this.productUnit,
      required this.productDescription})
      : super(key: key);
  final String? productName;
  final String? productImage;
  final num? productPrice;
  final String productDescription;
  final String? productId;
  final List productUnit;
  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  bool wishListBool = false;

  List<BoxShadow> get shadowList => [
        const BoxShadow(
            color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
      ];
  String? unitdata;
  var firstValue;
  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                if (value.exists)
                  {
                    setState(() {
                      wishListBool = value.get('wishList');
                    })
                  }
            });
  }

  double? price;
  @override
  Widget build(BuildContext context) {
    getWishListBool();
    WishListProvider wishListProvider = Provider.of(context);
    widget.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 177, 196, 206),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: App_Colors.Primary_Color,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 400,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 70),
                        child: Wrap(
                          children: [
                            Text(
                              "Description\n",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              widget.productDescription,
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                  tag: widget.productId!,
                  child: Image.network(
                    widget.productImage!,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 27, left: 12),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100,
              width: 350,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: shadowList,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.rupeeSign,
                          color: Colors.black,
                          size: 18,
                        ),
                        Text(
                          "${price ?? widget.productPrice}",
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .01),
                      child: InkWell(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: widget.productUnit.map((data) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: size.height * .02,
                                                horizontal: size.width * .01),
                                            child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  unitdata = data!;
                                                  if (unitdata == "250 Gram") {
                                                    price = .250 *
                                                        widget.productPrice!;
                                                  } else if (unitdata ==
                                                      "500 Gram") {
                                                    price = .500 *
                                                        widget.productPrice!;
                                                  } else if (unitdata ==
                                                      "1 Kg") {
                                                    price = 1.0 *
                                                        widget.productPrice!;
                                                  }
                                                });

                                                Navigator.of(context).pop();
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
                          height: MediaQuery.of(context).size.height * .035,
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
                                    color: Color.fromARGB(255, 10, 10, 10),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 120,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        setState(() {
                          wishListBool = !wishListBool;
                        });
                        if (wishListBool == true) {
                          wishListProvider.addWishListData(
                            wishListId: widget.productId,
                            wishListImage: widget.productImage,
                            wishListName: widget.productName,
                            wishListPrice: widget.productPrice,
                            description: widget.productDescription,
                            unit: unitdata ?? firstValue,
                            wishListQuantity: 1,
                          );
                        } else {
                          wishListProvider.deleteWishtList(widget.productId);
                        }
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 70,
                      decoration: BoxDecoration(
                          color: App_Colors.Primary_Color,
                          borderRadius: BorderRadius.circular(20)),
                      child: wishListBool == true
                          ? Icon(
                              Icons.favorite,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReviewCart(isover: true),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: App_Colors.Primary_Color,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text(
                          'Go to Cart',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.width * .6, top: size.height * .483),
            child: Container(
              width: size.width * .3,
              height: size.height * .04,
              child: count(
                productId: widget.productId,
                productImage: widget.productImage,
                productName: widget.productName,
                productPrice: price ?? widget.productPrice,
                productUnit: unitdata ?? firstValue,
                // productQuantity: "1",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
