import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/model/product_model.dart';
import 'package:food_app/pages/home/product.dart';
import 'package:food_app/pages/product/overe.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class herbPage extends StatefulWidget {
  herbPage({Key? key}) : super(key: key);

  @override
  State<herbPage> createState() => _herbPageState();
}

class _herbPageState extends State<herbPage> {
  @override
  // void initState() {
  //   ProductProvider productProvider = Provider.of(context, listen: false);
  //   productProvider.fatchHerbsProductData();
  //   productProvider.fatchFreshProductData();
  //   productProvider.fatchRootProductData();
  //   super.initState();
  // }
  List<dynamic> productunit = ['1 Kg', '500 Gram', '250 Gram'];
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App_Colors.Primary_Color,
        title: const Text(
          "Herbs Seasonings",
          style: TextStyle(fontSize: 18),
        ),
      ),
      backgroundColor: App_Colors.ScafoldeColor,
      body: AnimationLimiter(
        child: GridView.count(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(_w / 60),
          crossAxisCount: 2,
          children: List.generate(
            productProvider.getHerbsProductDataList.length,
            (int index) {
              ProductModel data =
                  productProvider.getHerbsProductDataList[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: Duration(milliseconds: 500),
                columnCount: 2,
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Screen2(
                                      productId: data.productId,
                                      productUnit: productunit,
                                      productImage: data.productImage,
                                      productName: data.productName,
                                      productPrice: data.productPrice,
                                      productDescription:
                                          data.productDescription!,
                                    )));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: _w / 30, left: _w / 60, right: _w / 60),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .140,
                              width: MediaQuery.of(context).size.height * .190,
                              // color: Colors.white,
                              child: Hero(
                                tag: data.productId,
                                child: Image(
                                  image: NetworkImage(data.productImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .015,
                            ),
                            Text(
                              data.productName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
