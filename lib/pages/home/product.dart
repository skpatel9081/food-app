import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/pages/product/overe.dart';
import 'package:food_app/widgets/count.dart';

class Product extends StatefulWidget {
  final String productImage;
  final String productName;
  final num productPrice;
  final String productId;
  final ProductModel productUnit;
  final String? productDescription;
  final Color bgcolor;
  Product({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productUnit,
    this.productDescription,
    required this.bgcolor,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

// ignore: camel_case_types
class _ProductState extends State<Product> {
  String? unitdata;
  num? price;
  var firstValue;
  List<dynamic> productunit = ['1 Kg', '500 Gram', '250 Gram'];
  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit?.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    Size size = MediaQuery.of(context).size;
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
      child: Container(
        // color: Colors.amber,
        height: 210,
        width: 400,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 150),
              child: Center(
                child: Container(
                  width: 200,
                  height: 160,
                  // margin: EdgeInsets.only(top: 60,bottom: 20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),

                      // boxShadow: shadowList,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * .06, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: size.height * .001,
                        ),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.rupeeSign,
                              color: Colors.black,
                              size: 18,
                            ),
                            Text(
                              "${price ?? widget.productPrice}",
                              style: TextStyle(fontSize: 18),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: widget
                                            .productUnit.productUnit!
                                            .map((data) {
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: size.height * .02,
                                                    horizontal:
                                                        size.width * .01),
                                                child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      unitdata = data!;
                                                      if (unitdata ==
                                                          "250Gram") {
                                                        price = .250 *
                                                            widget.productPrice;
                                                      } else if (unitdata ==
                                                          "500Gram") {
                                                        price = .500 *
                                                            widget.productPrice;
                                                      } else if (unitdata ==
                                                          "1Kg") {
                                                        price = 1.0 *
                                                            widget.productPrice;
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
                        SizedBox(
                          height: size.height * .04,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * .01),
                          child: Container(
                            width: size.width * .4,
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
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 190),
              child: Center(
                child: Container(
                  width: 160,
                  height: 190,
                  decoration: BoxDecoration(
                    color: widget.bgcolor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: shadowList,
                  ),
                  child: Hero(
                      tag: widget.productId,
                      child: Image.network(
                        widget.productImage,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            //  Align(
            //   child: Hero(
            //       tag:1,child: Image.asset('assets/a0.png')),
            // ),
          ],
        ),
      ),
    );
  }

  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey, blurRadius: 20, offset: Offset(1, 1))
  ];
}
