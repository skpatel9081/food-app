import 'package:flutter/material.dart';
import 'package:food_app/pages/product/overe.dart';
import 'package:food_app/provider/wishList_Provider.dart';
import 'package:provider/provider.dart';

class Wishlist_Iteam extends StatefulWidget {
  Wishlist_Iteam(
      {Key? key,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productUnit,
      required this.productId,
      this.productDescription})
      : super(key: key);
  final String productImage;
  final String productName;
  // ignore: non_constant_identifier_names
  final num productPrice;
  final String productUnit;
  final String productId;
  final String? productDescription;
  @override
  State<Wishlist_Iteam> createState() => _Wishlist_IteamState();
}

class _Wishlist_IteamState extends State<Wishlist_Iteam> {
  List<dynamic> productunit = ['250 Gram', '500 Gram', '1 Kg'];
  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    return InkWell(
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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: size.height * .120,
                  // color: Colors.blue,
                  child: Image(image: NetworkImage(widget.productImage)),
                )),
                SizedBox(
                  width: size.width * .02,
                ),
                Expanded(
                    child: Container(
                  height: size.height * .120,
                  // color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Text(widget.productUnit)
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  // color: Colors.blue,
                  child: IconButton(
                    onPressed: () {
                      // AlertDialog(
                      //   content: Center(
                      //     child: Text("Delete Iteam!"),
                      //   ),
                      //   actions: [
                      //     ElevatedButton(
                      //         onPressed: () {
                      //           wishListProvider.deleteWishtList(widget.productId);
                      //         },
                      //         child: Text("Yse")),
                      //     ElevatedButton(
                      //         onPressed: () {
                      //           Navigator.pop(context);
                      //         },
                      //         child: Text("No"))
                      //   ],
                      // );
                      Widget cancelButton = TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text("Yes"),
                        onPressed: () {
                          wishListProvider.deleteWishtList(widget.productId);
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
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
