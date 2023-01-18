import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';
import 'package:food_app/pages/Categories/fresh.dart';
import 'package:food_app/pages/Categories/herb.dart';
import 'package:food_app/pages/Categories/root.dart';
import 'package:food_app/pages/Categories/spices.dart';
import 'package:food_app/pages/home/drawer.dart';
import 'package:food_app/pages/home/product.dart';
import 'package:food_app/pages/review_cart/review_cart.dart';
import 'package:food_app/pages/search/Search.dart';
import 'package:food_app/provider/product_provider.dart';
import 'package:food_app/provider/user_provider.dart';
import 'package:food_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class Home_Page1 extends StatefulWidget {
  Home_Page1({Key? key}) : super(key: key);

  @override
  State<Home_Page1> createState() => _Home_Page1State();
}

enum _SelectedTab { home, favorite, search, person }

class _Home_Page1State extends State<Home_Page1> {
  ProductProvider? productProvider;
  bool isloading = true;
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    // productProvider.fatchHerbsProductData();
    // productProvider.fatchFreshProductData();
    productProvider.fatchSpicesProductData();
    check();
    super.initState();
  }

  check() async {
    final result = await Connectivity().checkConnectivity();
    showConnectivitySnackBar(result);
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have no internet please on connection';
    final color = hasInternet ? Colors.green : Colors.red;

    if (hasInternet == false) {
      Utils.showTopSnackBar(context, message, color, 150);
      isloading = false;
    } else {
      isloading = true;
    }
  }

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDragging = false;
  bool isDrawerOpen = false;
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      check();
    });
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    ProductProvider productProvider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    return isloading
        ? Scaffold(
            backgroundColor: Color.fromARGB(255, 224, 223, 220),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 224, 223, 220),
              title: Text(
                "Homepage",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Search(
                                searchlist:
                                    productProvider.getAllroductDataList,
                              )));
                    },
                    icon: Icon(Icons.search, size: 25, color: Colors.black)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReviewCart(),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart, color: Colors.black)),
              ],
            ),
            drawer: DrawerPage(userProvider: userProvider),
            body: SingleChildScrollView(
                // physics: NeverScrollableScrollPhysics(),
                child: HomePage(context, productProvider)),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Column HomePage(BuildContext context, ProductProvider productProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        // Container(
        //   // color:Color.fromARGB(255, 87, 112, 107),
        //   height: 65,
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        //       ),
        //       Text(
        //         "Homepage",
        //         style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //       SizedBox(
        //         width: 110,
        //       ),
        //       IconButton(
        //           onPressed: () {},
        //           icon: Icon(
        //             Icons.search,
        //             size: 25,
        //           )),
        //       IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
        //     ],
        //   ),
        // ),
        CarouselSlider(
          items: _imageURL.map((imagepath) {
            return Builder(builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(
                        imagepath,
                      ),
                      fit: BoxFit.cover),
                ),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 1),
                child: GestureDetector(),
              );
            });
          }).toList(),
          options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),

        Row(
          children: [
            catagoriesContainer(
              bgcolor: Colors.transparent,
              image: "assets/c4.png",
              title: "Spices",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => spicesPage(),
                    ));
              },
            ),
            catagoriesContainer(
              bgcolor: Colors.transparent,
              image: "assets/c2.jpg",
              title: "Fresh Fruit",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => freshPage(),
                    ));
              },
            ),
          ],
        ),
        Row(
          children: [
            catagoriesContainer(
              bgcolor: Colors.transparent,
              image: "assets/c3.png",
              title: "Root Vegetables",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => rootPage(),
                    ));
              },
            ),
            catagoriesContainer(
              bgcolor: Colors.transparent,
              image: "assets/c1.jpg",
              title: "Herbs Seasonings",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => herbPage(),
                    ));
              },
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Spices",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      searchlist: productProvider.spicesProductList,
                    ),
                  ),
                );
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // ignore: non_constant_identifier_names
            children: productProvider.getSpicesProductDataList
                .map((spiceProductData) {
              return Product(
                bgcolor: App_Colors.Primary_Color,
                productImage: spiceProductData.productImage,
                productName: spiceProductData.productName,
                productPrice: spiceProductData.productPrice,
                productId: spiceProductData.productId,
                productUnit: spiceProductData,
                productDescription: spiceProductData.productDescription,
              );
            }).toList(),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Fresh Fruit",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .23,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      searchlist: productProvider.getFreshProductDataList,
                    ),
                  ),
                );
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // ignore: non_constant_identifier_names
            children:
                productProvider.getFreshProductDataList.map((FreshProductData) {
              return Product(
                bgcolor: App_Colors.Primary_Color,
                productImage: FreshProductData.productImage,
                productName: FreshProductData.productName,
                productPrice: FreshProductData.productPrice,
                productId: FreshProductData.productId,
                productUnit: FreshProductData,
                productDescription: FreshProductData.productDescription,
              );
            }).toList(),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Root Vegetable",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .11,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      searchlist: productProvider.RootProductList,
                    ),
                  ),
                );
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // ignore: non_constant_identifier_names
            children:
                productProvider.getRootProductDataList.map((RootProductData) {
              return Product(
                bgcolor: App_Colors.Primary_Color,
                productImage: RootProductData.productImage,
                productName: RootProductData.productName,
                productPrice: RootProductData.productPrice,
                productId: RootProductData.productId,
                productUnit: RootProductData,
                productDescription: RootProductData.productDescription,
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Herbs Seasonings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .03,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(
                      searchlist: productProvider.getHerbsProductDataList,
                    ),
                  ),
                );
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 17, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // ignore: non_constant_identifier_names
            children:
                productProvider.getHerbsProductDataList.map((HerbProductData) {
              return Product(
                bgcolor: App_Colors.Primary_Color,
                productImage: HerbProductData.productImage,
                productName: HerbProductData.productName,
                productPrice: HerbProductData.productPrice,
                productId: HerbProductData.productId,
                productUnit: HerbProductData,
                productDescription: HerbProductData.productDescription,
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        )
      ],
    );
  }

  final List _source = [Colors.red, Colors.black, Colors.yellow];

  final List _imageURL = [
    'assets/n1.png',
    'assets/herb.jpg',
    'assets/11.png',
    'assets/fruit.jpg',
    'assets/33.png',
    'assets/55.png',
    'assets/n2.jpg',
  ];
  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
  ];
}

class catagoriesContainer extends StatelessWidget {
  const catagoriesContainer(
      {Key? key,
      required this.bgcolor,
      required this.image,
      required this.title,
      required this.ontap})
      : super(key: key);
  final Color bgcolor;
  final String image;
  final String title;
  final void Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .025,
            vertical: MediaQuery.of(context).size.height * .01),
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * .45,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.fitWidth),
            color: bgcolor,
            borderRadius: BorderRadius.circular(10)),
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height * .07,
            width: MediaQuery.of(context).size.width * .45,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.4),
                borderRadius: BorderRadius.circular(10)),
          ),
          Center(
            child: Text(title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }
}
