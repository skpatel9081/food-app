import 'package:flutter/material.dart';
import 'package:food_app/constant/color/colors.dart';

import 'package:food_app/pages/Wish_List/Wish_List.dart';
import 'package:food_app/pages/home/New_Home_Page.dart';
import 'package:food_app/pages/home/bottam_bar.dart';
import 'package:food_app/pages/my_profile/my_profile.dart';
import 'package:food_app/pages/review_cart/review_cart.dart';
import 'package:food_app/provider/user_provider.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({
    Key? key,
    this.userProvider,
  }) : super(key: key);
  final UserProvider? userProvider;

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  double fontsize = 17;
  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider!.currentUserData;
    Size size = MediaQuery.of(context).size;
    // var userData = widget.userprovider.currentUserData;
    return Drawer(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: App_Colors.black,
            body: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: App_Colors.black),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: size.height * .02),
                        child: CircleAvatar(
                          radius: 43,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              userData.userImage ??
                                  "https://firebasestorage.googleapis.com/v0/b/foodapp-1234.appspot.com/o/EXTRA%2FUSER.png?alt=media&token=71a8b177-f884-4af3-9cb3-14a109f7542c",
                            ),
                            radius: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * .05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // "Siddharth Savaliya",
                            userData.userName!,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                            height: size.height * .03,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * .2),
            child: Container(
              height: size.height * .8,
              color: App_Colors.ScafoldeColor,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Home2(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.home_outlined,
                        size: 28,
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontsize,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ReviewCart(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.shop_outlined,
                        size: 28,
                      ),
                      title: Text(
                        "Review Cart",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontsize,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyProfile(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person_outlined,
                        size: 28,
                      ),
                      title: Text(
                        "My Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontsize,
                        ),
                      ),
                    ),
                  ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.notifications_outlined,
                  //     size: 28,
                  //   ),
                  //   title: Text(
                  //     "Notificatio",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: fontsize,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.star_outline,
                  //     size: 28,
                  //   ),
                  //   title: Text(
                  //     "Rating & Review",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: fontsize,
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WishList(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.favorite_outline,
                        size: 28,
                      ),
                      title: Text(
                        "Wishlist",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontsize,
                        ),
                      ),
                    ),
                  ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.copy_outlined,
                  //     size: 28,
                  //   ),
                  //   title: Text(
                  //     "Raise a Complaint",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: fontsize,
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.format_quote_outlined,
                  //     size: 28,
                  //   ),
                  //   title: Text(
                  //     "FAQs",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: fontsize,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact Support"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Call us:"),
                            SizedBox(
                              width: 10,
                            ),
                            Text("+923352580282"),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Mail us:"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "dailyfoodcity22P@gmail.com",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
