import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/pages/home/New_Home_Page.dart';
import 'package:food_app/pages/home/bottam_bar.dart';
import 'package:food_app/pages/product/overe.dart';
import 'package:food_app/widgets/singel_item.dart';

class Search extends StatefulWidget {
  Search({Key? key, this.searchlist}) : super(key: key);
  final List<ProductModel>? searchlist;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> productunit = ['250 Gram', '500 Gram', '1 Kg'];
  String query = "";
  searchItem(String query) {
    List<ProductModel> searchFood = widget.searchlist!.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(query);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 224, 223, 220),
        leading: IconButton(
            onPressed: () {
              widget.searchlist!.clear();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Home2(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
        // backgroundColor: App_Colors.Primary_Color,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       print(widget.searchlist);
        //     },
        //     icon: const Icon(Icons.menu),
        //   )
        // ],
      ),
      body: Scaffold(
        backgroundColor: Color.fromARGB(255, 224, 223, 220),
        body: ListView(children: [
          ListTile(
            title: Text("Items"),
          ),
          Container(
            height: size.height * .06,
            margin: EdgeInsets.symmetric(horizontal: size.width * .05),
            child: TextFormField(
              style: TextStyle(
                color: App_Colors.black,
              ),
              autofocus: false,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)),
                hintMaxLines: 1,
                hintText: "Search for items in the store",
                errorStyle:
                    const TextStyle(color: Colors.redAccent, fontSize: 15),
                hintStyle: TextStyle(
                    fontSize: 14,
                    // color: Colors.white.withOpacity(.5),
                    color: App_Colors.black),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Column(
            children: _searchItem.map((data) {
              return Singel_item(
                  wishlist: false,
                  deleteWishlist: false,
                  issearch: true,
                  productUnitList: productunit,
                  productId: data.productId,
                  isbool: false,
                  productImage: data.productImage,
                  productDescription: data.productDescription,
                  productName: data.productName,
                  // productUnit: productunit,
                  productQuantity: data.productQuantity,
                  productPrice: data.productPrice);
            }).toList(),
          )
        ]),
      ),
    );
  }
}
